Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUHANWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUHANWN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 09:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUHANWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 09:22:13 -0400
Received: from mail.dif.dk ([193.138.115.101]:18627 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265932AbUHANWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 09:22:12 -0400
Date: Sun, 1 Aug 2004 15:26:45 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: shai lifshitz <slifshitz@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: check_region question
In-Reply-To: <BAY17-F431PAMiNAdAl00025bde@hotmail.com>
Message-ID: <Pine.LNX.4.60.0408011507270.2535@dragon.hygekrogen.localhost>
References: <BAY17-F431PAMiNAdAl00025bde@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004, shai lifshitz wrote:

> hi group,
> 
> I try to grap the parallel port of a PC (x86), so as the first step I do:
> "check_region(0x378,3);"

You want to use request_region() instead, check_region() is deprecated and 
everything still using it is being moved to use request_region().

also, take a look at drivers/parport/parport_pc.c for examples.

You can also get useful info from
cat /proc/ioports
cat /proc/iomem
cat /proc/modules

You may also want to take a look at http://www.xml.com/ldd/chapter/book/


--
Jesper Juhl <juhl-lkml@dif.dk>

