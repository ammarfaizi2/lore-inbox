Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVLZW1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVLZW1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVLZW1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:27:13 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:27552 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750792AbVLZW1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:27:11 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 07/36] m68k: Kconfig fix (mac vs. FONTS)
Date: Mon, 26 Dec 2005 22:56:41 +0100
User-Agent: KMail/1.8.2
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1EpIOZ-0004qS-GO@ZenIV.linux.org.uk>
In-Reply-To: <E1EpIOZ-0004qS-GO@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512262256.43405.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 22 December 2005 05:49, Al Viro wrote:

> mac won't build without non-modular FONTS, which requires non-modular
> FB and FRAMEBUFFER_CONSOLE

I'm not really happy about the select usage here. It rather looks something 
else should be disabled if FRAMEBUFFER_CONSOLE isn't enabled.
I guess it's about the console code in head.S? Wouldn't it be easier to 
disable CONSOLE there if CONFIG_FRAMEBUFFER_CONSOLE isn't set?

bye, Roman

