Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262872AbVCDLP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbVCDLP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVCDLNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:13:21 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:58262 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262780AbVCDLHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:07:01 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: swsusp: use non-contiguous memory on resume
Date: Fri, 4 Mar 2005 12:09:03 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       hugang@soulinfo.com
References: <20050304095934.GA1731@elf.ucw.cz> <20050304102121.GG1345@elf.ucw.cz> <20050304025119.4b3f8aa6.akpm@osdl.org>
In-Reply-To: <20050304025119.4b3f8aa6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503041209.04002.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 4 of March 2005 11:51, Andrew Morton wrote:
> Pavel Machek <pavel@suse.cz> wrote:
> >
> > Problem is that pagedir is allocated as order-8 allocation on resume
> >  in -mmX (and linus). Unfortunately, order-8 allocation sometimes
> >  fails, and for some people (Rafael, seife :-) it fails way too often.
> > 
> >  Solution is to change format of pagedir from table to linklist,
> >  avoiding high-order alocation. Unfortunately that means changes to
> >  assembly, too, as assembly walks the pagedir.
> 
> Ah.
> 
> >  (Or maybe Rafael is willing to create -mm version and submit it
> >  himself?)
> 
> No, against -linus, please.  But the chunk in kernel/power/swsusp.c looks
> like it came from a diff between -mm and -linus.  Or something.

Well, the patch is against -mm, because there already is a different version
of swsusp in -mm, which is needed for this patch to apply.

Originally, the patch consisted of two parts, the first one being fairly independent
on the second one, and the first part went into -mm before 2.6.11-rc4.

Now, I think it's better if I make a consolidated patch against 2.6.11.  Would
that be OK?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
