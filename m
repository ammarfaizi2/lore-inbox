Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317542AbSFEEzu>; Wed, 5 Jun 2002 00:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317547AbSFEEzt>; Wed, 5 Jun 2002 00:55:49 -0400
Received: from rj.SGI.COM ([192.82.208.96]:52627 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317542AbSFEEzs>;
	Wed, 5 Jun 2002 00:55:48 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.20 config forward references to CONFIG_X86_LOCAL_APIC
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Jun 2002 14:55:41 +1000
Message-ID: <21732.1023252941@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/config.in tests CONFIG_X86_LOCAL_APIC before it is defined.
dep_bool 'check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_LOCAL_APIC

arch/i386/config.in also includes drivers/acpi/Config.in which tests
CONFIG_X86_LOCAL_APIC before this variable is defined via CONFIG_SMP.

The forward references result in incorrect configurations when
switching config from one cpu type to another or from SMP to UP.

