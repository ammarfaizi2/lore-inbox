Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWFMUnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWFMUnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWFMUnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:43:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:27372 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932227AbWFMUnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:43:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [patch] s390: missing ifdef in bitops.h
Date: Tue, 13 Jun 2006 22:43:24 +0200
User-Agent: KMail/1.9.1
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
References: <20060613120916.GA9405@osiris.boeblingen.de.ibm.com> <1150211828.2844.20.camel@hades.cambridge.redhat.com> <200606132233.07830.arnd@arndb.de>
In-Reply-To: <200606132233.07830.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606132243.24584.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tuesday 13 June 2006 22:33 schrieb Arnd Bergmann:
> Erm, I don't think the kernel even uses those definitions, the only reason
> to keep them is old user space.

Sorry, misinformation on my side. The kernel uses the FD_foo versions,
not the __FD_foo ones, so I did not find them at first.

It's only used in fs/open.c though, and I wonder if that could just
use the bitops versions directly, as these are more likely to be
optimized well for a given architecture.

	Arnd <><
