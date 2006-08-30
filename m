Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWH3X0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWH3X0l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWH3X0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:26:40 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:32916 "EHLO
	asav00.insightbb.com") by vger.kernel.org with ESMTP
	id S1751106AbWH3X0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:26:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAP+69USBT4lXLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] drivers/input/misc/wistron_btns.c: fix section mismatch
Date: Wed, 30 Aug 2006 19:26:37 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
References: <20060826160922.3324a707.akpm@osdl.org> <20060830203520.GM18276@stusta.de>
In-Reply-To: <20060830203520.GM18276@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301926.37928.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 16:35, Adrian Bunk wrote:
> This patch fixes the following section mismatch
> (dmi_matched() is referenced from struct dmi_ids):
>

dmi_ids is only used in select_keymap, which is __init. Moreover,
dmi_ids is marked __initdata so I do not see what the problem is...
 
-- 
Dmitry
