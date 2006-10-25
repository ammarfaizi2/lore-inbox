Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423308AbWJYLvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423308AbWJYLvD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 07:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423311AbWJYLvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 07:51:03 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:65487 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1423308AbWJYLvB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 07:51:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Vasily Tarasov <vtaras@openvz.org>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
Date: Wed, 25 Oct 2006 13:50:21 +0200
User-Agent: KMail/1.9.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jan Kara <jack@suse.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Kagan <rkagan@sw.ru>,
       Randy Dunlap <rdunlap@xenotime.net>, Dmitry Mishin <dim@openvz.org>,
       Andi Kleen <ak@suse.de>, Vasily Averin <vvs@sw.ru>,
       Christoph Hellwig <hch@infradead.org>, Kirill Korotaev <dev@openvz.org>,
       OpenVZ Developers List <devel@openvz.org>
References: <200610251003.k9PA38kD018604@vass.7ka.mipt.ru> <200610251303.50551.arnd@arndb.de> <200610251125.k9PBPYMj020655@vass.7ka.mipt.ru>
In-Reply-To: <200610251125.k9PBPYMj020655@vass.7ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610251350.23748.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 October 2006 13:25, Vasily Tarasov wrote:
> Actually I didn't use __attribute__, 'case I'v heard,  that this isn't
> encouraged now to use __attribute__((...)) in kernel. But if you think it
> is ok, and even preferable, I will definitely redo it!

You shouldn't use attributes in ABI headers, because they are
not interpreted correctly by every compiler. For stuff inside
of the kernel, I don't see a reason against it.

	Arnd <><
