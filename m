Return-Path: <linux-kernel-owner+w=401wt.eu-S1753098AbWLWKUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbWLWKUv (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 05:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbWLWKUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 05:20:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56943 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbWLWKUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 05:20:50 -0500
Subject: Re: [PATCH -mm] MMCONFIG: Fix x86_64 ioremap base_address
From: Arjan van de Ven <arjan@infradead.org>
To: OGAWA Hirofumi <hogawa@miraclelinux.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
In-Reply-To: <lrfyb7ctm8.fsf@dhcp-0242.miraclelinux.com>
References: <lrfyb7ctm8.fsf@dhcp-0242.miraclelinux.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 23 Dec 2006 11:20:44 +0100
Message-Id: <1166869244.3281.590.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-23 at 10:02 +0900, OGAWA Hirofumi wrote:
> Current -mm's mmconfig has some problems of remapped range.
> 
> a) In the case of broken MCFG tables on Asus etc., we need to remap
> 256M range, but currently only remap 1M.


Hi,

I respectfully disagree. If the MCFG table is broken, we should not use
it AT ALL. It's either a correct table, and we can use it, or it's so
broken that we know it never has been tested etc etc, we're just better
of to not trust it in that case.

Greetings,
   Arjan van de Ven

