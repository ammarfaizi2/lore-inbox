Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbUDXSfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUDXSfX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 14:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUDXSfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 14:35:22 -0400
Received: from gprs214-118.eurotel.cz ([160.218.214.118]:33152 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262470AbUDXSfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 14:35:14 -0400
Date: Sat, 24 Apr 2004 20:35:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: ncunningham@linuxmail.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix error handling in "not enough swap space"
Message-ID: <20040424183505.GB2525@elf.ucw.cz>
References: <4089DC36.5020806@pointblue.com.pl> <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au> <4089E761.5050708@pointblue.com.pl> <opr6x0o10uruvnp2@laptop-linux.wpcb.org.au> <4089F0E5.3050006@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4089F0E5.3050006@pointblue.com.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I agree with you; it does sound like the process of eating memory is  
> >grabbing all the swap. I can't see how it could be doing that, 
> >however. If  you really want to use Pavel's version, I'd suggest 
> >adding some more debug  statements. Perhaps print out the number of 
> >swap pages free at the start  of that loop.
> >
> Ok, now funny bit happends. Simple program like that:
> while(1){
>    char *a=malloc(1024*1024*16);
>    if (a==NULL)
>       break;
> }
> 
> can allocate only about 200MB, than exits. That's the fist thing.

That's bad. That's even without swsusp, right? Again, test on 2.6.5
and post test case. Something is probably wrong in 2.6.6-bk. 

> Second one, starting KDE, and when swap usage != 0 (just to be sure 
> there is no problem with any assumption), gives me loads of error 
> messages (see attached file).

Can you try CONFIG_PREEMPT=n?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
