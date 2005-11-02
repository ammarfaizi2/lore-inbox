Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965325AbVKBWmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965325AbVKBWmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965330AbVKBWmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:42:45 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:3211 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965325AbVKBWmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:42:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=IqeEVl0LYWX/E+/knHKLfnApl2OH68e5bcRxVJZBJk8TU+uERJUGOQkQdue7Phw25EZlxKacTfnUXwFzlz17zfxvO3RPVK1fRQZxyBYHHRvm/BkakZ3s6kV9klsV05azk3yKpIdlEZhKudIT1VVSdcrfZBifQ7WoV/4zBsG3iLg=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: "Kai Tan" <mineown@hotmail.com>
Subject: Re: [uml-devel] Uml left showstopper bugs for 2.6.14
Date: Wed, 2 Nov 2005 23:47:37 +0100
User-Agent: KMail/1.8.3
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <BAY101-F4507935C4D38603757606B66E0@phx.gbl>
In-Reply-To: <BAY101-F4507935C4D38603757606B66E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511022347.37645.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 22:44, Kai Tan wrote:
> I tried the first patch, got the following error:
>
> Kernel panic - not syncing: copy_context_skas0 : failed to wait for
> SIGUSR1/SIGTRAP, pid = 7182, n = 7182, errno = 0, status = 0xb7f
Ok, segmentation fault, again:
$ ./testprogs/waitstatus $[0xb7f]
WSTOPSIG(status) is 11
The signal is: Segmentation fault

> I got the same error even after applying the second patch.
Oh, sorry.
Can you just try doing a "make clean" and forcing a full recompilation? In any 
case, I will try investigating further... I'll probably request you to give 
me the complete binary (without debug info and compressed) along with 
your .config. Please save them for now, I must check further before...

For now, IIRC you can keep running with mode=tt, right?

> My run command is the following:
>
> linux stderr=1 ubd0=../../root_fs.rh-7.2-full.pristine.20020312

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
____________________________________
Con Yahoo! Mail proteggi la tua casella di posta da virus e posta indesiderata
http://mail.yahoo.com

