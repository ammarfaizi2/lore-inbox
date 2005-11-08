Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbVKHONm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbVKHONm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbVKHONm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:13:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57870 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965202AbVKHONl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:13:41 -0500
Date: Tue, 8 Nov 2005 15:13:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: libata PATA patches
Message-ID: <20051108141340.GT3847@stusta.de>
References: <1131460386.25192.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131460386.25192.45.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 02:33:06PM +0000, Alan Cox wrote:

> I've put a new patch versus 2.6.14-mm1 on 
> http://zeniv.linux.org.uk/~alan/IDE

I'm wondering about the -m32 additions at the top of your patch.

Shouldn't the following at the top of arch/i386/Makefile already do the 
same?

HAS_BIARCH      := $(call cc-option-yn, -m32)
ifeq ($(HAS_BIARCH),y)
AS              := $(AS) --32
LD              := $(LD) -m elf_i386
CC              := $(CC) -m32
endif



> Alan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

