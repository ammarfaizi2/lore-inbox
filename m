Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUJBQUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUJBQUP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 12:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUJBQS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 12:18:59 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:9877 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267312AbUJBQPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 12:15:41 -0400
Subject: Re: [linux-usb-devel] Re: new locking in change_termios breaks USB
	serial drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Borchers <alborchers@steinerpoint.com>
Cc: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <415D9E96.1030207@steinerpoint.com>
References: <415D3408.8070201@steinerpoint.com>
	 <1096630567.21871.4.camel@localhost.localdomain>
	 <415D84A3.6010105@steinerpoint.com>
	 <1096645773.21958.54.camel@localhost.localdomain>
	 <415D9E96.1030207@steinerpoint.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096729712.25129.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 02 Oct 2004 16:08:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-01 at 19:14, Al Borchers wrote:
> * The tty layer could use a semaphore so the USB serial set_termios could
>    sleep until the new termios settings have taken effect before returning.

This seems to be the right choice and is the change I will implement.

