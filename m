Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263386AbTCNQkt>; Fri, 14 Mar 2003 11:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263399AbTCNQkt>; Fri, 14 Mar 2003 11:40:49 -0500
Received: from employees.nextframe.net ([213.160.234.200]:56822 "EHLO
	toosexy.nextframe.net") by vger.kernel.org with ESMTP
	id <S263386AbTCNQks>; Fri, 14 Mar 2003 11:40:48 -0500
Date: Fri, 14 Mar 2003 17:53:17 +0100
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.64-ac4
Message-ID: <20030314165317.GA543@toosexy>
Reply-To: morten.helgesen@nextframe.net
References: <200303141509.h2EF9R017016@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303141509.h2EF9R017016@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-Editor: VIM - Vi IMproved 6.1
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, 

On Fri, Mar 14, 2003 at 10:09:27AM -0500, Alan Cox wrote:
> Linux 2.5.64-ac4

it looks like someone changed the prototypes in includes/linux/fb.h 
without changing the actual functions ... 

-extern void cfb_fillrect(struct fb_info *info, struct fb_fillrect *rect);
-extern void cfb_copyarea(struct fb_info *info, struct fb_copyarea *area);
-extern void cfb_imageblit(struct fb_info *info, struct fb_image *image);
+extern void cfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
+extern void cfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
+extern void cfb_imageblit(struct fb_info *info, const struct fb_image *image);

drivers/video/cfbcopyarea.c:346: conflicting types for `cfb_copyarea'
include/linux/fb.h:459: previous declaration of `cfb_copyarea'
make[3]: *** [drivers/video/cfbcopyarea.o] Error 1
make[2]: *** [drivers/video] Error 2

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
morten.helgesen@nextframe.net / 93445641
http://www.nextframe.net
