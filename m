Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWBPB0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWBPB0x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 20:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWBPB0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 20:26:53 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39563 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751197AbWBPB0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 20:26:52 -0500
Subject: Re: [PATCH 2/2] strndup_user, convert (keyctl)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davi Arnaut <davi.arnaut@gmail.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060215182316.fadf8e71.davi.arnaut@gmail.com>
References: <20060215182316.fadf8e71.davi.arnaut@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Feb 2006 01:30:06 +0000
Message-Id: <1140053406.14831.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-15 at 18:23 -0300, Davi Arnaut wrote:
> Convert security/keys/keyctl.c string duplication to strdup_user()

Even if your implementation of strndup_user was correct this may break
stuff in some obscure cases that worked before as you've changed the
behaviour from PAGE_SIZE to 4096 and they are not the same on all
platforms.

