Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbUBYEmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 23:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbUBYEmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 23:42:05 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:13970 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S262480AbUBYEmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 23:42:03 -0500
Date: Tue, 24 Feb 2004 23:32:09 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Christophe Saout <christophe@saout.de>
Cc: James Morris <jmorris@intercode.com.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: cryptoapi highmem bug
Message-ID: <20040225043209.GA1179@certainkey.com>
References: <1077655754.14858.0.camel@leto.cs.pocnet.net> <20040224223425.GA32286@certainkey.com> <1077663682.6493.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077663682.6493.1.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 12:01:24AM +0100, Christophe Saout wrote:
> Am Di, den 24.02.2004 schrieb Jean-Luc Cooke um 23:34:
> 
> > What is calling cbc_process directly?  I don't see how any other function
> > could possibly call this function directly.
> 
> Nobody is calling it directly.
> 
> > cipher.c's cipher() function called cbc_process() with two different src and
> > dst buffers, *always*.
> 
> It you pass the same to ->encrypt_iv (like kblockd for reads) it will
> kmap the same page twice and call cbc_process with two different virtual
> addresses pointing to the same page.

Ah right.  Wanring: this is a cryptographer hacking kernel - danger!

How do I check for equal real addresses from two virtual ones?

JLC

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
