Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWASXlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWASXlv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWASXlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:41:50 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:31925 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750817AbWASXlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:41:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=tZKJiLle6Sz5ELzYxdaS/8WoR+/MVFXEOJZmmNFNE4snFTVI42kGz0I6jd9ItCCP4KNR4HAAtdoMoMF8kGPLLv5BqhYKpzREiDX/S1MsqvJHmDvGuS8crPgxkVaFPxL2AAfT4xrdYodmbricboZhrLjLP29yH2PTGBemFfmuJyU=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 8/8] uml: avoid "CONFIG_NR_CPUS undeclared" bogus error messages
Date: Fri, 20 Jan 2006 00:41:08 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
References: <20060118235132.4626.74049.stgit@zion.home.lan> <200601191601.31805.blaisorblade@yahoo.it> <20060119194356.GA8670@ccure.user-mode-linux.org>
In-Reply-To: <20060119194356.GA8670@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601200041.14590.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 January 2006 20:43, Jeff Dike wrote:
> On Thu, Jan 19, 2006 at 04:01:28PM +0100, Blaisorblade wrote:
> > Gerd Knorr in his tty patch, instead, used forward declarations, like:
> >
> > struct task_struct;
> >
> > what about that?

> I don't think so.  At least when you use void *, you are using a type
> that's not incorrect.  In userspace code, those task_structs start
> referring to host task_structs, which is definitely very wrong.

Possibly yes, but as long as we don't dereference the pointer (and in a 
prototype you're not going to do that) there's no problem.

Using a type makes the code clearer, and it doesn't hide any warning GCC may 
give (behaving well is left to us only).

In fact, btw (before I forget) we have currently the wrong errno used in 
sys-i386/ldt.c. Just wrote the fix (it's adding a silly os_ptrace_ldt). Going 
to compile and send.

> > Those functions probably should be moved anyway because they're
> > useless there

> Yeah.

> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
