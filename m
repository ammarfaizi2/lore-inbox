Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262284AbTDAKsm>; Tue, 1 Apr 2003 05:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbTDAKsm>; Tue, 1 Apr 2003 05:48:42 -0500
Received: from AGrenoble-101-1-4-18.abo.wanadoo.fr ([217.128.202.18]:63685
	"EHLO awak") by vger.kernel.org with ESMTP id <S262284AbTDAKsm>;
	Tue, 1 Apr 2003 05:48:42 -0500
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
From: Xavier Bestel <xavier.bestel@free.fr>
To: CaT <cat@zip.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20030401081045.GD1394@zip.com.au>
References: <20030401081045.GD1394@zip.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1049194788.22942.9.camel@bip.localdomain.fake>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Apr 2003 12:59:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                        size = memparse(value,&rest);
+                       if (*rest == '%') {
+                               struct sysinfo si;
+                               si_meminfo(&si);
+                               size = (si.totalram << PAGE_CACHE_SHIFT) / 100 * size;

(si.totalram << PAGE_CACHE_SHIFT) * size / 100;
would have been better precision-wise.

	Xav

