Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317119AbSEXKG0>; Fri, 24 May 2002 06:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317121AbSEXKGZ>; Fri, 24 May 2002 06:06:25 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:11276 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317119AbSEXKGY>; Fri, 24 May 2002 06:06:24 -0400
Date: Fri, 24 May 2002 11:06:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?Fran=E7ois_Leblanc?= <francois.leblanc@cev-sa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel 2.4.18 endianness logical mistakes correction on fbcon-cfb2.c and fbcon-cfb4.c
Message-ID: <20020524110618.A7299@flint.arm.linux.org.uk>
In-Reply-To: <004001c20309$2832c4c0$6601a8c0@stlo.cevsa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 11:55:38AM +0200,  François Leblanc wrote:
> This patchs correct the endianness logical of nibbletab, the first table is
> u_char mades so no endian needed and the second swap correctly bytes in
> LITTLE_ENDIAN. (old version swap half bytes instead of bytes).

A recent discussion on the ARM mailing lists has highlighted that hardware
designers seem to like connecting such things like LCD panels up to devices
in weird and wonderful ways - sometimes with a set of 4 pixels reversed,
sometimes with even weirder connectivity.  I've pointed them at the
framebuffer dev list.

Certainly your fbcon-cfb4 changes will break at least one of my machines
here.

Please talk this over with the framebuffer dev list.

	linux-fbdev-devel@lists.sourceforge.net

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

