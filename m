Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTHUK2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 06:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbTHUK2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 06:28:48 -0400
Received: from desnol.ru ([217.150.58.74]:45063 "EHLO desnol.ru")
	by vger.kernel.org with ESMTP id S262571AbTHUK2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 06:28:47 -0400
From: "agri" <agri@desnol.ru>
To: linux-kernel@vger.kernel.org
Reply-To: agri@desnol.ru
Subject: kernel include if_arp.h
Date: Thu, 21 Aug 2003 14:21:50 +0400
Message-Id: <20030821142150.M95606@desnol.ru>
X-Mailer: Open WebMail 1.64 20020415
X-OriginatingIP: 217.150.59.18 (agri)
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i was trying to compile squid-2.5.STABLE3 with arp acl support in my
i686-pc-linux-gnu box.

squid/src/acl.c include <linux/if_arp.h>
so while compiling i got warning that an include file should not be used
outside the kernel

modifying linux/if_arp.h:

#ifdef __KERNEL__
#include <linux/netdevice.h>
#endif

resolve the problem

Agri


