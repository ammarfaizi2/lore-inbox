Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWINW7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWINW7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWINW7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:59:49 -0400
Received: from mail.tmr.com ([64.65.253.246]:9419 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S932103AbWINW7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:59:48 -0400
Message-ID: <4509DFF0.4040309@tmr.com>
Date: Thu, 14 Sep 2006 19:04:16 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: R: Linux kernel source archive vulnerable
References: <20060907182304.GA10686@danisch.de> <Pine.LNX.4.61.0609121619470.19976@chaos.analogic.com> <ee796o$vue$1@taverner.cs.berkeley.edu> <45073B2B.4090906@lsrfire.ath.cx> <ee7m7r$6qr$1@taverner.cs.berkeley.edu>
In-Reply-To: <ee7m7r$6qr$1@taverner.cs.berkeley.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > Chris
David Wagner wrote:
> Rene Scharfe  wrote:
>> [details on how GNU tar works, snipped]
> 
> Again, you miss my point.  I already know how tar works, but that's not
> my point.  Why is it that people are so unwilling to address the real
> issue here?  Let's try a few facts:

Okay:
- you have been told told read the old posts on this topic
- you read but didn't understand
- the problem is YOU ARE DOING IT WRONG and untarring as root

The time to discuss where to put the umask was "back when," and I might 
have agreed then, but now I can't see any justification to change, 
because someone else would then have a problem. You want it to do 
something else on your system, so do it. You shouldn't untar as root anyway.

You have not only beaten a dead horse, but dragged the carcass through 
the streets.
> 
>     (a) The Linux kernel tar archive contains files with world-writeable
>     permissions.
> 
>     (b) There is no need for those files to have world-writeable
>     permissions.  It doesn't serve any particular purpose.  If the
>     permissions in the tar archive were changed to be not world-writeable,
>     no harm would be done.
> 
>     (c) Some users may get screwed over by virtue of the fact that those
>     files are listed in the tar archive with world-writeable permissions.
>     (Sure, if every user was an expert on "tar" and on security, then
>     maybe no one would get screwed over.  But in the real world, that's
>     not the case.)
> 
>     (d) Consequently, the format of the Linux kernel tar archive is
>     exposing some users to unnecessary riskis.
> 
>     (e) The Linux kernel folks could take a quick and easy step that
>     would eliminate this risk.  That step would involve storing the
>     files in the tar archive with permissions that were more reasonable
>     (not world-writeable would be a good start!).  This step wouldn't
>     hurt anyone.  There's no downside.
> 
>     (f) Yet the Linux kernel folks refuse to take this step, and any
>     time someone mentions that there is something the Linux kernel folks
>     could do about the problem, someone tries to change the topic to
>     something else (e.g., complaints about bugs in GNU tar, suggestions
>     that the user should invoke tar with some other option, claims that
>     this question has been addressed before, you name it).
> 
> So why is it that the tar archive is structured this way?  Why are
> the Linux kernel folks unnecessarily exposing their users to risk?
> What purpose, exactly, does it serve to have these files stored with
> world-writeable permissions?
> 
> Folks on the Linux kernel mailing list seem to be reluctant to admit these
> facts forthrightly.  The posts I've seen mostly seem to have little or
> no sympathy for users who get screwed over.  The attitude seems to be:
> if you get screwed over, it's your fault and your problem.  Why is that?
> If there is a simple step that Linux developers can take to eliminate
> this risk, why is there such reluctance to take it, and why is there
> such eagerness to point the finger at someone else?
> 
> The way I see it, storing files in a tar archive with world-writeable
> permissions is senseless.  Why do such a strange thing on purpose?
> 
> It all seems thoroughly mysterious to me.


-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
