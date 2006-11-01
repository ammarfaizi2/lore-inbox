Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992667AbWKAQsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992667AbWKAQsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992668AbWKAQsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:48:40 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:492 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S2992667AbWKAQsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:48:39 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: preferred way of fw loading
Date: Wed, 1 Nov 2006 17:48:31 +0100
User-Agent: KMail/1.9.5
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       R.E.Wolff@bitwizard.nl
References: <4547E720.4080505@gmail.com>
In-Reply-To: <4547E720.4080505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611011748.31781.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 November 2006 01:15, Jiri Slaby wrote:
> is preferred to have firmware in kernel binary (and go through array of chars)
> or userspace (and load it through standard kernel api)?

If you control the whole system, the ideal way is to have the system
firmware or boot loader come with the firmware blob and avoid worrying
about it in linux entirely. E.g. if you are using Open Firmware, you
can have the binary image as a property of the device in your device
tree, where Linux then goes looking for it.

	Arnd <><
