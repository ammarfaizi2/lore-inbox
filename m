Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbRESP7u>; Sat, 19 May 2001 11:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261843AbRESP7j>; Sat, 19 May 2001 11:59:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29715 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261839AbRESP7W>; Sat, 19 May 2001 11:59:22 -0400
Subject: Re: Hang&Oops on boot using latest -ac kernels with irda
To: Roel.Teuwen@advalvas.be (Roel Teuwen)
Date: Sat, 19 May 2001 16:56:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <990261578.1069.0.camel@omniroel> from "Roel Teuwen" at May 19, 2001 10:39:37 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15195j-0008UP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Code;  c0204004 <irda_device_event+4/20>   <=====
>    0:   66 81 78 5c 0f 03         cmpw   $0x30f,0x5c(%eax)   <=====

Someone passed NULL to a netdevice notifier. That isnt allowed. Your call
trace indicates that it was passed by dev_open which would itself have oopsed
in that situation.

Beats me, and I also haven't managed to duplicate it


