Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWAKLVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWAKLVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 06:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWAKLVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 06:21:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751440AbWAKLVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 06:21:17 -0500
Date: Wed, 11 Jan 2006 03:20:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joerg Sommrey <jo@sommrey.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] amd76x_pm: C2 powersaving for AMD K7
Message-Id: <20060111032057.7569be8a.akpm@osdl.org>
In-Reply-To: <20060110194622.GA14645@sommrey.de>
References: <20060110194622.GA14645@sommrey.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Sommrey <jo@sommrey.de> wrote:
>
>  +static void
>  +config_amd768_C2(int enable)
>  +{
>  +	unsigned char regbyte;
>  +
>  +	/* Set C2 options in DevB:3x4F, page 100 in AMD-768 doc */
>  +	pci_read_config_byte(pdev_sb, 0x4F, &regbyte);
>  +	if(enable)
>  +		regbyte |= C2EN;
>  +	else
>  +		regbyte ^= C2EN;

 &= ?
