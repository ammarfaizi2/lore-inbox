Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264242AbRFSOnX>; Tue, 19 Jun 2001 10:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264246AbRFSOnN>; Tue, 19 Jun 2001 10:43:13 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:47114 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264242AbRFSOnI>;
	Tue, 19 Jun 2001 10:43:08 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac15 -- Unresolved symbols "gameport_register_port" 
In-Reply-To: Your message of "Tue, 19 Jun 2001 16:35:20 +0200."
             <20010619163520.A12869@suse.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Jun 2001 00:43:02 +1000
Message-ID: <20719.992961782@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001 16:35:20 +0200, 
Vojtech Pavlik <vojtech@suse.cz> wrote:
>On Wed, Jun 20, 2001 at 12:30:05AM +1000, Keith Owens wrote:
>> Gameports and joysticks should not be available unless input core
>> support is selected first.  Invalid configs were slipping through.
>
>Gameports are not input core dependent.
>Only joysticks are.

drivers/char/Makefile says
subdir-$(CONFIG_INPUT) += joystick

Gameports are in subdir joystick.  Certainly looks dependent on
CONFIG_INPUT to me.

