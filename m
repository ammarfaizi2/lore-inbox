Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274988AbTHFUfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270995AbTHFUfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:35:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:14804 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274988AbTHFUeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:34:25 -0400
Date: Wed, 6 Aug 2003 13:34:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adam Belay <ambx1@neo.rr.com>
Cc: torvalds@osdl.org, misha@nasledov.com, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 PCMCIA Issues
Message-Id: <20030806133450.31da90e4.akpm@osdl.org>
In-Reply-To: <20030806114225.GI13275@neo.rr.com>
References: <20030804232204.GA21763@nasledov.com>
	<20030805144453.A8914@flint.arm.linux.org.uk>
	<20030806045627.GA1625@nasledov.com>
	<200308060559.h765xhI05860@mail.osdl.org>
	<20030806114225.GI13275@neo.rr.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay <ambx1@neo.rr.com> wrote:
>
> [PCMCIA] Fix PnP Probing in i82365.c
>  pnp_x_valid returns 1 if valid.  Therefore we should be using !pnp_port_valid.
>  Also cleans up some formatting issues.

This patch fixes the insertion-time hang on the A21P, with CONFIG_I82365=y
