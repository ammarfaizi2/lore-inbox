Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVBYVdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVBYVdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVBYVdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:33:51 -0500
Received: from web50203.mail.yahoo.com ([206.190.38.44]:44391 "HELO
	web50203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261667AbVBYVdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:33:39 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=l71wvLyEcztxrayE6fbgQmG720XRmguYJv2F+CBQ64/siBFmHVPT7NX9JjToisFNHnB4Ac8B2xe/cRgaf9fTfe9BGDOqfC5STPK5STIvsmIc/XaZ9NiVyhaLfkQ4yQcZFbYJmeoarwAaVfHXFQUfpg/upLaHQRm41K1LIbBpeN4=  ;
Message-ID: <20050225213336.58742.qmail@web50203.mail.yahoo.com>
Date: Fri, 25 Feb 2005 13:33:36 -0800 (PST)
From: Johan Braennlund <johan_brn@yahoo.com>
Subject: ALPS touchpad not seen by 2.6.11 kernels
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I've had trouble with my ALPS touchpad on my Acer Aspire, ever
since ALPS support was merged into the kernel. I've tried various
kernels from 2.6.11-rc3 to -rc5 (including some -mm kernels) and none
of them detect the pad. After sprinkling some printk's in the mouse
drivers, it seems like psmouse_connect in psmouse-base.c is never even
called. 

On the other hand, using earlier kernels (such as 2.6.9) with the
kernel patch from Peter Osterlund's driver package works fine. In that
case, I get lines like this in syslog:

kernel: alps.c: E6 report: 00 00 64
kernel: alps.c: E7 report: 73 02 14
kernel: alps.c: E6 report: 00 00 64
kernel: alps.c: E7 report: 73 02 14
kernel: alps.c: Status: 15 01 0a
kernel: ALPS Touchpad (Glidepoint) detected
kernel: input: AlpsPS/2 ALPS TouchPad on isa0060/serio4

With the newer kernels, there's nothing ALPS-related in the log. Any
pointers on what to look for would be appreciated. My kernel config is
at http://nullinfinity.org/config-2.6.11-rc5

Thanks,

Johan



		
__________________________________ 
Do you Yahoo!? 
Read only the mail you want - Yahoo! Mail SpamGuard. 
http://promotions.yahoo.com/new_mail 
