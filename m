Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTEIPNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 11:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTEIPNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 11:13:45 -0400
Received: from [66.186.193.1] ([66.186.193.1]:54278 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id S262177AbTEIPNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 11:13:44 -0400
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 64.122.104.99
X-Authenticated-Timestamp: 11:31:41(EDT) on May 09, 2003
X-HELO-From: [10.134.0.76]
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 64.122.104.99
Subject: RE: ALSA busted in 2.5.69
From: Torrey Hoffman <thoffman@arnor.net>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <XFMail.20030509100906.pochini@shiny.it>
References: <XFMail.20030509100906.pochini@shiny.it>
Content-Type: text/plain
Organization: 
Message-Id: <1052493821.1209.6.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 May 2003 08:23:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 01:09, Giuliano Pochini wrote:
> On 08-May-2003 Torrey Hoffman wrote:
> > ALSA isn't working for me in 2.5.69.  It appears to be because
> > /proc/asound/dev is missing the control devices.
...
> If you are not using devfs, you need to create the devices. There is a
> script in the ALSA-driver package to do that. Otherwise I can't help
> you because I never tried devfs and linux 2.5.x.

No.  /dev/snd is a symbolic link to /proc/asound/dev,
and that symbolic link was created by the script you mention.
(I am not using devfs.)

So the missing "/dev/snd/controlC0" should actually be created
by the ALSA modules in the proc filesystem as
"/proc/asound/dev/controlC0".  But only the timer device is there.

(This works under Red Hat 9's standard kernel with the ALSA 0.9.3
drivers, by the way.)

Torrey


