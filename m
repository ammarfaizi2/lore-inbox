Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWECASP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWECASP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 20:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWECASP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 20:18:15 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:36819 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965052AbWECASO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 20:18:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Wed, 3 May 2006 02:18:14 +0200
User-Agent: KMail/1.9.1
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <20060429232812.825714000@localhost.localdomain> <200605021259.24157.arnd@arndb.de> <801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org>
In-Reply-To: <801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605030218.14428.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wednesday 03 May 2006 01:38 schrieb Segher Boessenkool:
> > - it requires a few properties in the device tree (local-mac-address,
> >   firmware), so it should also depend on PPC
>
> The portions of code that require OF should have appropriate #ifdef  
> guards.

Why should we? Getting the mac address and the firmware into the
chip is rather essential to make it work. When there is an #ifdef
around that code, it will only produce a non-working driver that can
be compiled everywhere instead of a driver that can only be compiled
on platforms where it has a chance of working.

If someone has the need to make it work somewhere else, it's easy
enough to change to code to whatever other method is used to set up
the chip.

	Arnd <><
