Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSGQTJF>; Wed, 17 Jul 2002 15:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSGQTJF>; Wed, 17 Jul 2002 15:09:05 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:56847 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316322AbSGQTJE>;
	Wed, 17 Jul 2002 15:09:04 -0400
Date: Wed, 17 Jul 2002 21:18:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bitops operate on unsigned long
Message-ID: <20020717211817.A7164@mars.ravnborg.org>
References: <Pine.GSO.4.21.0207021303460.25055-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0207021303460.25055-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Jul 02, 2002 at 01:05:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 01:05:01PM +0200, Geert Uytterhoeven wrote:
> 
> Bitops must operate on unsigned long.
> -u32 zorro_unused_z2ram[4] = { 0, 0, 0, 0 };
> +unsigned long zorro_unused_z2ram[128/BITS_PER_LONG];

Consider using bitmap_member from linux/types.h

	Sam
