Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbUD1X1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUD1X1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUD1X1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:27:46 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:4689 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261472AbUD1X0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:26:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
Date: Wed, 28 Apr 2004 18:24:03 -0500
User-Agent: KMail/1.6.1
Cc: Erik Steffl <steffl@bigfoot.com>
References: <40853060.2060508@bigfoot.com> <200404280741.08665.dtor_core@ameritech.net> <408FFC2A.3080504@bigfoot.com>
In-Reply-To: <408FFC2A.3080504@bigfoot.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404281824.05044.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 April 2004 01:47 pm, Erik Steffl wrote:
> Dmitry Torokhov wrote:
> 
> > What protocol are you using in XFree?
> 
>    that's irrelevant, I got the results above without X running (by 

No, it is not. Please change protocol in XF86Config to ExplorerPS/2.
 
> reading /dev/psaux). In case it might shed some light anyway, here's the 
> X info: protocol is MouseManPlusPS/2, it worked with kernel 2.4.x. Now 
> (with 2.6.5) X reports same results as you see above (using xev I see 
> the wheel is no event, side button is button 2, just like wheel click)
>

Kernel only provides emulation of 3 protocols via /dev/psaux: bare PS/2,
IntelliMouse PS/2 and Explorer PS/2. Since your program does not issue
Intellimouse or Explorer protocol initialization sequences it gets just
bare PS/2 protocol data - 2 axis, 3 buttons. Extra buttons are mapped onto
first 3. For exact mapping consult drivers/input/mousedev.c
 

-- 
Dmitry
