Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUEYAXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUEYAXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 20:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbUEYAXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 20:23:18 -0400
Received: from mx2.redhat.com ([66.187.237.31]:36007 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S264228AbUEYAXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 20:23:17 -0400
Date: Mon, 24 May 2004 17:23:13 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Beno_t Dejean <TazForEver@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] typo in drivers/usb/class/usblp.c (resend)
Message-Id: <20040524172313.207aaac6.zaitcev@redhat.com>
In-Reply-To: <mailman.1085393760.20566.linux-kernel2news@redhat.com>
References: <mailman.1085393760.20566.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004 12:11:29 +0200

> i think there's a typo error in usblp.c

>         if (~status & LP_PERRORP)
>                 newerr = 3;
> -       if (status & LP_POUTPA)
> +       if (~status & LP_POUTPA)
>                 newerr = 1;

This is not a typo. Please refer to the USP Printer Class Specification,
chapter 4.2.2 "GET_PORT_STATUS (bRequest = 1)". Bit mask 0x20 consitutes
a one-bit field "Paper Emtpy", with values: 1 = Paper Empty, 0 = Paper
Not Empty.

-- Pete
