Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262393AbSJLIf6>; Sat, 12 Oct 2002 04:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262397AbSJLIf5>; Sat, 12 Oct 2002 04:35:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27523 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262393AbSJLIf5>;
	Sat, 12 Oct 2002 04:35:57 -0400
Date: Sat, 12 Oct 2002 01:35:07 -0700 (PDT)
Message-Id: <20021012.013507.27779687.davem@redhat.com>
To: dilinger@mp3revolution.net
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] sparc64 makefile dep fix for uart_console_init
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021012082405.GB10000@chunk.voxel.net>
References: <20021012082405.GB10000@chunk.voxel.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andres Salomon <dilinger@mp3revolution.net>
   Date: Sat, 12 Oct 2002 04:24:05 -0400

   drivers/serial/Config.in defines the following:
   if [ "$CONFIG_SPARC32" = "y" -o "$CONFIG_SPARC64" = "y" ]; then
   	define_bool CONFIG_SERIAL_SUNCORE y
   	define_bool CONFIG_SERIAL_CORE_CONSOLE y
   
   There are no deps for CONFIG_SERIAL_CORE_CONSOLE in
   drivers/serial/Makefile

Yeah that's weird.  Just enable one of the sun serial
drivers for now and it will fix itself.

Probably a fix could be to add CONFIG_SERIAL_SUNCORE to the
checks that set CONFIG_SERIAL_CORE, I think that's how I'll
fix this.
