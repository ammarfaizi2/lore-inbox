Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265283AbUFAXuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbUFAXuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 19:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUFAXuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 19:50:24 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:40375 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265283AbUFAXuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 19:50:20 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: SERIO_USERDEV patch for 2.6
Date: Tue, 1 Jun 2004 18:50:15 -0500
User-Agent: KMail/1.6.2
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>
References: <Pine.GSO.4.58.0406011105330.6922@stekt37> <200406011318.36992.dtor_core@ameritech.net> <MPG.1b272042f54382879896b4@news.gmane.org>
In-Reply-To: <MPG.1b272042f54382879896b4@news.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406011850.16136.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 June 2004 05:23 pm, Giuseppe Bilotta wrote:
> Dmitry Torokhov wrote:
> > echo "rawdev" > /sys/bus/serio/devices/serio0/driver
> > 
> > or something alont these lines. At least that's my grand plan ;)
> 
> I like this kind of idea. Many options should be settable this 
> way (think for example about Synaptics and ALPS touchpad 

Yes, exactly, it will allow much more flexible option handling. Still,
as far as your examples go: 

> configurations: whether to use multipointers separately or 
> together,
- userspace task - always persent separate devices and have application
  (GPM or X) multiplex data together.

> (de)activation of tapping,
- may be userspace task - i.e can be done in userspace if device can
  report BTN_TOUCH event. If not then kernel has to toggle it.

> button remapping etc).  
- userspace task

-- 
Dmitry
