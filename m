Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262952AbSJBDdG>; Tue, 1 Oct 2002 23:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262953AbSJBDdG>; Tue, 1 Oct 2002 23:33:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3011 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262952AbSJBDdF>;
	Tue, 1 Oct 2002 23:33:05 -0400
Date: Tue, 01 Oct 2002 20:31:31 -0700 (PDT)
Message-Id: <20021001.203131.48516382.davem@redhat.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: 2.5.39 + evms 1.2.0 burn test
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021002032548.GB11871@kroah.com>
References: <20021002030422.GA2127@merlin.emma.line.org>
	<20021002032548.GB11871@kroah.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Greg KH <greg@kroah.com>
   Date: Tue, 1 Oct 2002 20:25:49 -0700

   On Wed, Oct 02, 2002 at 05:04:22AM +0200, Matthias Andree wrote:
   > 
   > 5. usb: usbkbd (module) cannot be loaded, missing symbol:
   >    usb_kbd_free_buffers.
   
   Vojtech, I've seen this for a while, but forgot to mention it.  Any fix?
   
sed 's/usb_kbd_free_buffers/usb_kbd_free_mem/' <usbkbd.c >usbkbd_fixed.c
mv usbkbd_fixed.c usbkbd.c
make

You can tell that most of us use full HID support. :-)
