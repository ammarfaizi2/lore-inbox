Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRCUKJd>; Wed, 21 Mar 2001 05:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131278AbRCUKJX>; Wed, 21 Mar 2001 05:09:23 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:51724 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131275AbRCUKJJ>;
	Wed, 21 Mar 2001 05:09:09 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Antwerpen, Oliver" <Antwerpen@netsquare.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to provoke kernel panic 
In-Reply-To: Your message of "Wed, 21 Mar 2001 10:43:25 BST."
             <9DD550E9A9B0D411A16700D0B7E38BA4E67E@POL-EML-SRV1> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Mar 2001 21:08:22 +1100
Message-ID: <23971.985169302@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001 10:43:25 +0100, 
"Antwerpen, Oliver" <Antwerpen@netsquare.org> wrote:
>Could someone kindly tell me how to provoke a kernel panic? I need to do so
>for testing some applications regarding system crash awareness.

Create fs/example-module.c

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/module.h>

int init_module(void)
{
	printk("module loading\n");
	panic("test panic\n");
	return 0;
}

Add "obj-m += example-module.o" to fs/Makefile.
make modules, insmod fs/example-module.o and watch the bits fly.

