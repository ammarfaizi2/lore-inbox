Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWHTSHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWHTSHq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWHTSHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:07:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24732 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751110AbWHTSHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:07:45 -0400
Subject: Re: [PATCH] char/moxa.c: fix endianess and multiple-card issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dirk Eibach <eibach@gdsys.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <44E5A6DE.7090402@gdsys.de>
References: <44E5A6DE.7090402@gdsys.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:28:48 +0100
Message-Id: <1156098529.4051.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 13:39 +0200, ysgrifennodd Dirk Eibach:
> From: Dirk Eibach <eibach@gdsys.de>
> 
> While testing Moxa C218T/PCI on PowerPC 405EP I found that loading 
> firmware using the linux kernel driver fails because calculation of the 
> checksum is not endianess independent in the original code.

> Signed-off-by: Dirk Eibach <eibach@gdsys.de>

Acked-by: Alan Cox <alan@redhat.com>

Checksum changes are clearly correct. Other changes is an improvement
but not I think enough to handle malicious firmware attacks. That said
such an attacker has CAP_SYS_RAWIO anyway so that part is irrelevant
except for neatness

