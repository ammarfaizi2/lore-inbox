Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287939AbSABUHe>; Wed, 2 Jan 2002 15:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287936AbSABUHO>; Wed, 2 Jan 2002 15:07:14 -0500
Received: from svr3.applink.net ([206.50.88.3]:58886 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287931AbSABUHN>;
	Wed, 2 Jan 2002 15:07:13 -0500
Message-Id: <200201022006.g02K6vSr021827@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Tony Hoyle <tmh@nothing-on.tv>, timothy.covell@ashavan.org
Subject: Re: system.map
Date: Wed, 2 Jan 2002 14:03:15 -0600
X-Mailer: KMail [version 1.3.2]
Cc: adrian kok <adriankok2000@yahoo.com.hk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201021930.g02JUCSr021556@svr3.applink.net> <3C336209.8000808@nothing-on.tv>
In-Reply-To: <3C336209.8000808@nothing-on.tv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 13:39, Tony Hoyle wrote:
> Timothy Covell wrote:
> > 	Of course, you can copy over the new System.map
> > file to /boot,  but their is no (easy) way of having more than
> > one active version via "lilo" or "grub".   And that could be
> > considered a deficiency of the Linux OS.
>
> ????  Just call it System.map-2.2.17, System.map-2.5.1, etc.  Sounds
> pretty 'easy' to me.
>
> 'make install' does all this for you, btw.
>
> Tony

Not on grub.  I quote:
	It is also possible to do "make install" if you have lilo 
	installed to suit the kernel makefiles,
  	but you may want to check your particular lilo setup first.

But, on my grub based system, I have to:

1.  "make bzlilo"  which creates vmlinuz and System.map 
and puts them in / and not in /boot.  (make bzlilo is easier to use
than bzimage)

2. cp /vmlinuz /boot/vmlinuz-x.y.x  ;  cp /System.map /boot/System.map-x.y.z

3. rm /boot/System.map ; ln -s /boot/System.map-x.y.z /boot/System.map

4. vi /boot/grub.conf (or /etc/grub.conf) and put in new kernel boot entry.

5. sync;sync;shutdown -r now


-- 
timothy.covell@ashavan.org.
