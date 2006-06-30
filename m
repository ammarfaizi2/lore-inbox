Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWF3MDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWF3MDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWF3MDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:03:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62634 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932113AbWF3MDD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:03:03 -0400
Subject: Re: [2.6 patch] mm/util.c: EXPORT_UNUSED_SYMBOL
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060630113251.GR19712@stusta.de>
References: <20060630113251.GR19712@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Jun 2006 13:17:34 +0100
Message-Id: <1151669854.31392.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 13:32 +0200, ysgrifennodd Adrian Bunk:
>  }
> -EXPORT_SYMBOL(strndup_user);
> +EXPORT_UNUSED_SYMBOL(strndup_user);  /*  June 2006  */

Adrian, will you please differentiate between symbols which are
logically part of an API and symbols that were for some purpose and are
not now being used.

This sort of symbol removal/marking is just causing noise and confusion
without actually doing anything useful, unlike the many symbols that
genuinely were exported for some weird reason and were no longer needed.

