Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVA2Xab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVA2Xab (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVA2Xab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:30:31 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:62070 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261602AbVA2Xa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:30:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Possible bug in keyboard.c (2.6.10)
Date: Sat, 29 Jan 2005 18:30:24 -0500
User-Agent: KMail/1.7.2
Cc: Andries Brouwer <aebr@win.tue.nl>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34> <20050128215939.GF6010@pclin040.win.tue.nl> <20050129111233.GA2268@ucw.cz>
In-Reply-To: <20050129111233.GA2268@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501291830.24532.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 January 2005 06:12, Vojtech Pavlik wrote:
> However, on 2.6, where you can have more than one keyboard, it'd be
> better to use the EVIOCSKEYCODE ioctl on the event device instead of the
> KDSKEYCODE ioctl on the console, as the later only changes the first
> found keyboard.
> 

FWIW I changed atkbd so every keyboard has separate keymap (so one can set
one keyboard to set 2 and other to set 3). I think it should be possible to
adjust keymaps on individual keyboards to accurately map keys when keyboards
are different.

-- 
Dmitry
