Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbSKPBhC>; Fri, 15 Nov 2002 20:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267186AbSKPBhC>; Fri, 15 Nov 2002 20:37:02 -0500
Received: from lakemtao08.cox.net ([68.1.17.113]:29579 "EHLO
	lakemtao08.cox.net") by vger.kernel.org with ESMTP
	id <S267184AbSKPBhB>; Fri, 15 Nov 2002 20:37:01 -0500
From: steve roemen <sdroemen@cox.net>
Reply-To: sdroemen@cox.net
To: jburks@wavicle.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.47 bk latest pull
Date: Fri, 15 Nov 2002 19:43:51 -0600
User-Agent: KMail/1.5
References: <20021116012156Z267181-32597+23019@vger.kernel.org>
In-Reply-To: <20021116012156Z267181-32597+23019@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211151943.51968.sdroemen@cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik replied with this:

Are you using the Rusty's modutils, or the old, no-longer-works-with-2.5 
modutils?

i was still using modutils 2.4.19  so that is the problem.

i asked jeff where the new modutils is and he replied:

search for Rusty's module-related patches on lkml, I don't have a URL 
handy, sorry :(

They don't work with 2.4.x... currently there is a hack solution where 
Rusty's modutils "make install" renames the current modutils to 
<program>.old.  Then when you run Rusty's modprobe, if it's a 2.4 
kernel, the program will do nothing more than exec modprobe.old.  (I 
don't like it that way, but such as it is with a development kernel...)


anybody have the url for these new modutils?


-steve



On Friday 15 November 2002 11:08 am, Joe Burks wrote:
> I've had this same problem using 2.5.47bk4 from kernel.org.
>
> I also noticed that make modules_install no longer runs depmod, so my
> module dependencies didn't get set up until I ran depmod manually which
> then exposed the QM_MODULES problem.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

