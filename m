Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVBKMCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVBKMCW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 07:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVBKMCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 07:02:22 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:35847 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262122AbVBKMCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 07:02:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TchAqgFAalbQMVk03j2LeBSQYijRkTr2J16wcJbqzBk6m86aCwm1QzVf5LUfZQPL1P+NpeDpHguAdN4TqKpGR1orJeVoMSHllpqdvMWj+eMNIfB3q0v180ABDW9PQ6SwPeuQfzGo225BS6Q1BVTDj6CvsPwO6QyByXAVZ1v/mak=
Message-ID: <84144f02050211040253e33dab@mail.gmail.com>
Date: Fri, 11 Feb 2005 14:02:19 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       Jean Delvare <khali@linux-fr.org>, Pekka Enberg <penberg@gmail.com>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
In-Reply-To: <20050211113636.GI3263@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050210161809.GK3493@crusoe.alcove-fr>
	 <20050211113636.GI3263@crusoe.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2005 12:36:37 +0100, Stelian Pop <stelian@popies.net> wrote:
> +static int __init sony_acpi_add(struct acpi_device *device)
> +{
> +       acpi_status status = AE_OK;
> +       struct sony_snc *snc = NULL;
> +       int result;
> +
> +       snc = kmalloc(sizeof(struct sony_snc), GFP_KERNEL);
> +       if (!snc)
> +               return -ENOMEM;
> +       memset(snc, 0, sizeof(struct sony_snc));

Nitpick: use kcalloc() instead of kmalloc() and memset().

                                 Pekka
