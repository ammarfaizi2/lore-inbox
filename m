Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289951AbSAWSDk>; Wed, 23 Jan 2002 13:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289950AbSAWSDa>; Wed, 23 Jan 2002 13:03:30 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:12186 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S289945AbSAWSDR>; Wed, 23 Jan 2002 13:03:17 -0500
Date: Wed, 23 Jan 2002 21:02:46 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Dave Jones <davej@suse.de>
Cc: miles@megapathdsl.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.3-pre3 -- aironet4500_core.c:2839:  In function `awc_init': incompatible types in return
Message-Id: <20020123210246.5e5cfb3f.johnpol@2ka.mipt.ru>
In-Reply-To: <20020123140044.E31032@suse.de>
In-Reply-To: <1011771248.24309.60.camel@stomata.megapathdsl.net>
	<20020123104550.16b160b0.johnpol@2ka.mipt.ru>
	<20020123140044.E31032@suse.de>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002 14:00:44 +0100
Dave Jones <davej@suse.de> wrote:

>  > -       return NODEV;
>  > +       return -1;

>  This should probably be return -ENODEV

It sould be negative integer.
kdev_val(NODEV) == 0, so it will indicate successive finish, that is not
right.

> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs

	Evgeniy Polyakov ( s0mbre ).
