Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSG3VHh>; Tue, 30 Jul 2002 17:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSG3VHg>; Tue, 30 Jul 2002 17:07:36 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:61701 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316576AbSG3VHf>;
	Tue, 30 Jul 2002 17:07:35 -0400
Date: Tue, 30 Jul 2002 14:09:38 -0700
From: Greg KH <greg@kroah.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
Message-ID: <20020730210938.GA16657@kroah.com>
References: <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz> <20020730152255.A20071@ucw.cz> <20020730152342.B20071@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730152342.B20071@ucw.cz>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 02 Jul 2002 18:36:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 03:23:42PM +0200, Vojtech Pavlik wrote:
> -#include <asm/types.h>
> +#include <stdint.h>

Why?  I thought we were not including any glibc (or any other libc)
header files when building the kernel?

> -	__u16 bustype;
> -	__u16 vendor;
> -	__u16 product;
> -	__u16 version;
> +	uint16_t bustype;
> +	uint16_t vendor;
> +	uint16_t product;
> +	uint16_t version;

{sigh}  __u16 is _so_ much nicer, and tells the programmer, "Yes I know
this variable needs to be the same size in userspace and in
kernelspace."

Just my two cents.

greg k-h
