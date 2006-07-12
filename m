Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWGLLqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWGLLqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWGLLqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:46:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32475 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751354AbWGLLqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:46:18 -0400
Subject: Re: [PATCH -mm] IDE core: must_check fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm <akpm@osdl.org>
In-Reply-To: <20060711204555.3b12eba4.rdunlap@xenotime.net>
References: <20060711204555.3b12eba4.rdunlap@xenotime.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 13:04:08 +0100
Message-Id: <1152705848.22943.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-07-11 am 20:45 -0700, ysgrifennodd Randy.Dunlap:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Check all __must_check warnings in IDE core.

Most of those should be panic() calls. If they happen you don't want to
continue running with your storage system in a half defined stated. Its
far better you die before anything worse happens.


