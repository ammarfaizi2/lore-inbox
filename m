Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUIOU0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUIOU0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267391AbUIOUYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:24:06 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:9411 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267388AbUIOUXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:23:37 -0400
Subject: Re: [PATCH] hvc_console fix to protect hvc_write against ldisc
	write after hvc_close
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095273835.3294.278.camel@localhost>
References: <1095273835.3294.278.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095276020.20569.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 20:20:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-15 at 19:43, Ryan Arnold wrote:
> So this patch checks tty->driver_data in hvc_write() before it is used. 
> Hopefully once Alan Cox's patch is checked in ldisc writes won't
> continue to happen after tty closes.

Actually for the short term I may have made the ldisc calling tty race
worse. I'm still looking into some of that. I've fixed the one the other
way but for now driver defensively 8)

