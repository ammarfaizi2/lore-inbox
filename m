Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVA3Ac7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVA3Ac7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 19:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVA3Acj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 19:32:39 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:34444 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261619AbVA3Acg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 19:32:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
Date: Sat, 29 Jan 2005 19:32:31 -0500
User-Agent: KMail/1.7.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home> <200501291840.12694.dtor_core@ameritech.net> <Pine.LNX.4.61.0501300053580.30794@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501300053580.30794@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501291932.31430.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 January 2005 18:56, Roman Zippel wrote:
> Hi,
> 
> On Sat, 29 Jan 2005, Dmitry Torokhov wrote:
> 
> > I can assure you that serio_raw driver _does not_ use input system - it is
> > implementation of pre 2.6 /dev/psaux interface giving you access to raw AUX
> > data. It was written so we can still use PS/2 devices for which we don't have
> > proper in-kernel driver but have working userspace solution. It completely
> > bypasses input layer.
> 
> That's fine, but why is it in the input menu? How do you suggest to make 
> it selectable without selecting input and without messing the menu 
> structure?
> 

Well, probably split input into sections, one of the options would be
something like "Generic Input Layer" and have evdev, mousedev, etc
depend on it. serio will not depend on it... nor will gameport as
I can see someone wanting gameport_raw.

-- 
Dmitry
