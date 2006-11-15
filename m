Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966788AbWKOLGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966788AbWKOLGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 06:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966790AbWKOLGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 06:06:25 -0500
Received: from iona.labri.fr ([147.210.8.143]:32708 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S966788AbWKOLGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 06:06:25 -0500
Message-ID: <455AF4AE.9030606@ens-lyon.org>
Date: Wed, 15 Nov 2006 12:06:22 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc5: known regressions (v3)
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061115102122.GQ22565@stusta.de>
In-Reply-To: <20061115102122.GQ22565@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Subject : unable to rip cd
> References : http://lkml.org/lkml/2006/10/13/100
> http://lkml.org/lkml/2006/11/8/42
> Submitter : Alex Romosan <romosan@sycorax.lbl.gov>
> Handled-By : Jens Axboe <jens.axboe@oracle.com>
> Status : Jens is investigating

I think this one is already fixed.

Brice




commit 616e8a091a035c0bd9b871695f4af191df123caa
author Jens Axboe <jens.axboe@oracle.com> 1163437499 +0100
committer Linus Torvalds <torvalds@g5.osdl.org> 1163440020 -0800

[PATCH] Fix bad data direction in SG_IO

Contrary to what the name misleads you to believe, SG_DXFER_TO_FROM_DEV
is really just a normal read seen from the device side.

This patch fixes http://lkml.org/lkml/2006/10/13/100


