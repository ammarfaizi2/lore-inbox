Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267916AbTAHUcS>; Wed, 8 Jan 2003 15:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267918AbTAHUcR>; Wed, 8 Jan 2003 15:32:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45067 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267916AbTAHUcN>; Wed, 8 Jan 2003 15:32:13 -0500
Message-ID: <3E1C8CD2.4070402@zytor.com>
Date: Wed, 08 Jan 2003 12:40:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI code:  why need  outb (0x01, 0xCFB); ?
References: <3014AAAC8E0930438FD38EBF6DCEB5647D0D1C@fmsmsx407.fm.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:
>
> Normally all accesses should be long (0xcf8/0xcfc) but x86 is byte addresseable and some chipsets do support byte accesses. 
> We do not encourage use of byte accesses as it will not be supported in future platforms.
> 

The PCI standard is quite explicit: byte accesses are permitted to the
data window (0xCFC) and not permitted to the address window (0xCF8).
Accepting byte accesses to the address window, or not supporting byte
accesses to the data window, *will* result in breakage (I can attest to
this fact quite well.)

	-hpa


