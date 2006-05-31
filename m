Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751665AbWEaEQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWEaEQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWEaEQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:16:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:38682 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751662AbWEaEQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:16:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dY7N0DhQylae13iJWOAKubHgDL3mBvl1WVrqn1xQhOi1mkP5Re1gbCMw0Tf8bOU/263AGmD/U3mUseg6yyltwQN4UN60Qz9xdkhbULZZBwiVdArML0+NFqbiSAxO5ws8ottFLIO41REvB6qGfIkQrU8J2c/7UiC78dZCVpg/Jz8=
Message-ID: <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
Date: Wed, 31 May 2006 00:16:37 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Dave Airlie" <airlied@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <200605302314.25957.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com>
	 <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>
	 <200605302314.25957.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, D. Hazelton <dhazelton@enter.net> wrote:
> Like I've said, this has gone onto my list. Now to get back to the code... I
> really do want to see about getting this stuff into the kernel ASAP.

You might want to leave the DRM hot potato alone for a while and just
work on fbdev. Fbdev is smaller and it is easier to get changes
accepted.

A small project would be to get secondary adapter reset working. I
believe the work would be well received by the fbdev people.

You can start by using vbetool with a slight modification to get the
ROM image from sysfs
Then add the check in fbcore to see if it is a secondary adapter.
Modify /sys/class/firmware/ to handle generic helpers instead of just
the firmware one
After you get that going make the real reset app with emu86 support, etc
Finally modify the ROM attribute so that you can write the altered ROM
image back in
Keep everything as a separate project until the kernel (klibc merge)
tree is ready to accept it

This is not a big project but it could take up to a month to complete
since you need to familiarize yourself with how everything works.

-- 
Jon Smirl
jonsmirl@gmail.com
