Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbSJWLhK>; Wed, 23 Oct 2002 07:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbSJWLhK>; Wed, 23 Oct 2002 07:37:10 -0400
Received: from kim.it.uu.se ([130.238.12.178]:3009 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261407AbSJWLhK>;
	Wed, 23 Oct 2002 07:37:10 -0400
Date: Wed, 23 Oct 2002 13:43:13 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210231143.NAA02865@kim.it.uu.se>
To: abslucio@terra.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.44] compile error whit LOCAL_APIC disabled...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Oct 2002 14:28:26 -0300, Lucio Maciel wrote:
> <cut arch/i386/config.in>
> if [ "$CONFIG_X86_LOCAL_APIC" = "y" ]; then
> 	define_bool CONFIG_X86_EXTRA_IRQS y
> 	define_bool CONFIG_X86_FIND_SMP_CONFIG y
> 	define_bool CONFIG_X86_MPPARSE y
> fi
> </cut>
> 
> CONFIG_X86_MPPARSE that should only be enabled when LOCAL_APIC is enable to, is getting always enable
> breaking the compile...

Known bug in scripts/Configure when switching from an APIC-enabled to
an APIC-disabled config. `make oldconfig' fixes it.
