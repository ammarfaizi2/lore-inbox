Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbUKLAHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbUKLAHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUKLAHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:07:05 -0500
Received: from dsl017-059-236.wdc2.dsl.speakeasy.net ([69.17.59.236]:8685 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP id S262478AbUKLAEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:04:12 -0500
Date: Thu, 11 Nov 2004 19:11:45 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: a.out issue
Message-ID: <20041112001145.GB22336@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041111220906.GA1670@dereference.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111220906.GA1670@dereference.de>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.9
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 11:09:07PM +0100, Florian Heinz took 20 lines to write:
> Hi ppl,
> 
> there seems to be a bug related to a.out-binfmt.
> 
> try executing this binary:
> perl -e'print"\x07\x01".("\x00"x13)."\xc0".("\x00"x16)'>eout
> (it may be neccessary to turn memory overcommit on before)
> 
> This should result in a kernel-oops.
> Doing this in a loop will eat fd's and memory.
> 
> seems like find_vma_prepare does not what insert_vm_struct expects when
> the whole addresspace is occupied.

No oops over here, with overcommit set to 0, 1, or 2.
$ uname -a
Linux luther 2.6.9 #12 Sun Oct 31 07:43:57 EST 2004 i686 unknown unknown
GNU/Linux

Kurt
-- 
Keep Cool, but Don't Freeze
	- Hellman's Mayonnaise
