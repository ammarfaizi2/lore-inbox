Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319474AbSH3HnQ>; Fri, 30 Aug 2002 03:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319475AbSH3HnQ>; Fri, 30 Aug 2002 03:43:16 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:19206 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S319474AbSH3HnQ>; Fri, 30 Aug 2002 03:43:16 -0400
Date: Fri, 30 Aug 2002 09:47:30 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: pwaechtler@mac.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 6/41 sound/oss/pss.c - convert cli to spinlocks
Message-ID: <20020830074730.GF19611@louise.pinerecords.com>
References: <200208292154.g7TLs5ZH003520@smtp-relay02.mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208292154.g7TLs5ZH003520@smtp-relay02.mac.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 4 days, 5:14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> static pss_confdata *devc = &pss_data;
                           ^ ^
> +static spinlock_t lock=SPIN_LOCK_UNLOCKED;

> 				if (!pss_put_dspword(devc, *data++)) {
                                                          ^
> +					spin_unlock_irqrestore(&lock,flags);


Would you please take care not to clutter the original sources with
lines in a different C formatting style?
