Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUKLDnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUKLDnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 22:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbUKLDnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 22:43:42 -0500
Received: from dsl017-059-236.wdc2.dsl.speakeasy.net ([69.17.59.236]:61677
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S262434AbUKLDnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 22:43:37 -0500
Date: Thu, 11 Nov 2004 22:51:12 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Florian Heinz <heinz@cronon-ag.de>, linux-kernel@vger.kernel.org
Subject: Re: a.out issue
Message-ID: <20041112035112.GA2075@kurtwerks.com>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	Florian Heinz <heinz@cronon-ag.de>, linux-kernel@vger.kernel.org
References: <20041111220906.GA1670@dereference.de> <20041111192727.R14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111192727.R14339@build.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.9
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 07:27:27PM -0800, Chris Wright took 39 lines to write:
> * Florian Heinz (heinz@cronon-ag.de) wrote:
> > seems like find_vma_prepare does not what insert_vm_struct expects when
> > the whole addresspace is occupied.
> 
> The setup_arg_pages() is inserting an overlapping region.  If nothing
> else, this will fix that problem.   Perhaps there's a better solution.

It solves the oops here (I didn't get the oops at first because I didn't
have CONFIG_BINFMT_AOUT set). Sort of. Now I just get "Killed" with
vm.overcommit_memory set to 1; with it set to 0 I get a seg fault.

Kurt
-- 
Let He who taketh the Plunge Remember to return it by Tuesday.
