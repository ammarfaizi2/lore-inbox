Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSFEIgF>; Wed, 5 Jun 2002 04:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSFEIgE>; Wed, 5 Jun 2002 04:36:04 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:30915 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313687AbSFEIgE>; Wed, 5 Jun 2002 04:36:04 -0400
Date: Wed, 5 Jun 2002 10:07:15 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 config forward references to CONFIG_X86_LOCAL_APIC
In-Reply-To: <21732.1023252941@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0206051002210.26634-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

On Wed, 5 Jun 2002, Keith Owens wrote:

> arch/i386/config.in tests CONFIG_X86_LOCAL_APIC before it is defined.
> dep_bool 'check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_LOCAL_APIC
> 
> arch/i386/config.in also includes drivers/acpi/Config.in which tests
> CONFIG_X86_LOCAL_APIC before this variable is defined via CONFIG_SMP.
> 
> The forward references result in incorrect configurations when
> switching config from one cpu type to another or from SMP to UP.

We could move the conditional to preprocessor time by wrapping certain 
bits in #ifdef (urgh), what really is the more elegant way of doing it?

Regards,
	Zwane Mwaikambo
-- 
http://function.linuxpower.ca
		


