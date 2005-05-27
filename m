Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVE0Dhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVE0Dhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 23:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVE0Dhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 23:37:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8094 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261869AbVE0Dhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 23:37:43 -0400
Date: Thu, 26 May 2005 23:37:37 -0400
From: Dave Jones <davej@redhat.com>
To: P Lavin <lavin.p@redpinesignals.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error in building modules into kernel.
Message-ID: <20050527033737.GB29450@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	P Lavin <lavin.p@redpinesignals.com>, linux-kernel@vger.kernel.org
References: <4296952A.4080309@redpinesignals.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4296952A.4080309@redpinesignals.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 09:04:02AM +0530, P Lavin wrote:
 > Hi,
 > Can anyone tell me why i'm getting this error when i'm trying to build 
 > my driver into kernel ??
 > I'm using fedora-2 with linux-2.6.6
 > 
 >  CC      drivers/net/wireless/rsi_pine1/wpa/rc4.o
 >  CC      drivers/net/wireless/rsi_pine1/wpa/aes_wrap.o
 >  CC      drivers/net/wireless/rsi_pine1/wpa/md5.o
 >  CC      drivers/net/wireless/rsi_pine1/wpa/sha1.o
 >  CC      drivers/net/wireless/rsi_pine1/wpa/common.o
 >  CC      drivers/net/wireless/rsi_pine1/wpa/wpa_ap.o
 >  CC      drivers/net/wireless/rsi_pine1/wpa/ieee802_1x.o
 >  LD      drivers/net/wireless/rsi_pine1/rsiap.o
 >  LD      drivers/net/wireless/rsi_pine1/built-in.o
 >  LD      drivers/net/wireless/built-in.o
 >  LD      drivers/net/built-in.o
 >  LD      drivers/built-in.o
 >  GEN     .version
 >  CHK     include/linux/compile.h
 >  UPD     include/linux/compile.h
 >  CC      init/version.o
 >  LD      init/built-in.o
 >  LD      .tmp_vmlinux1
 > drivers/built-in.o(.exit.text+0xdab): In function `cleanup_module':
 > : multiple definition of `cleanup_module'
 > kernel/built-in.o(.text+0x18f0c): first defined here
 > ld: Warning: size of symbol `cleanup_module' changed from 1 in 
 > kernel/built-in.o to 40 in drivers/built-in.o
 > drivers/built-in.o(.init.text+0xf9fb): In function `init_module':
 > : multiple definition of `init_module'
 > kernel/built-in.o(.text+0x18580): first defined here
 > ld: Warning: size of symbol `init_module' changed from 3 in 
 > kernel/built-in.o to 166 in drivers/built-in.o
 > make: *** [.tmp_vmlinux1] Error 1

Probably something simple in the declarations of the init/cleanup routines.
Where's the source for this driver ?

		Dave
