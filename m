Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVBKLFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVBKLFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 06:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVBKLFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 06:05:49 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:17005 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262249AbVBKLFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 06:05:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Bz0SbLZzMczS0UIWZiMpB1zuWogmAiWihtHTNU2SpSfc1ZlGcJkcV/gwsBM2mGdkmiJuIMDjhNPGI0+WNfpBhLGjF2XP7pmNGAvEL0Vu5CJBoqfZGAs4t1jz0whTReU8q50GSvFBo4/zQqf0UMdzd4RoyCEouE5lqCmImnJXqrM=
Message-ID: <84144f0205021103052b244f9@mail.gmail.com>
Date: Fri, 11 Feb 2005 13:05:45 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
In-Reply-To: <20050210161809.GK3493@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050210161809.GK3493@crusoe.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 17:18:10 +0100, Stelian Pop <stelian@popies.net> wrote:
> +static int sony_acpi_write_brt(struct file *file, const char __user *buffer, unsigned long count, void *data)
> +{
> +       struct sony_snc *snc = (struct sony_snc *) data;

The casts for void pointer conversiosn are spurious. Please drop them.

                                  Pekka
