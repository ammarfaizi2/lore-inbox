Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTEGTIH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264209AbTEGTIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:08:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51076 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264208AbTEGTIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:08:00 -0400
Date: Wed, 07 May 2003 11:12:45 -0700 (PDT)
Message-Id: <20030507.111245.25138161.davem@redhat.com>
To: arnd@arndb.de
Cc: pavel@ucw.cz, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305072113.07004.arnd@arndb.de>
References: <20030507152856.GF412@elf.ucw.cz>
	<1052323484.9817.14.camel@rth.ninka.net>
	<200305072113.07004.arnd@arndb.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnd Bergmann <arnd@arndb.de>
   Date: Wed, 7 May 2003 21:13:07 +0200

   Btw: is there any bit in the ioctl number definition that can
   be (ab)used for compat_ioctl?

Unfortunately no.  All the bits are used in order to allow
the size field of the encoding to be as large as possible.
