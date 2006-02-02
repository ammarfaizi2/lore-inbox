Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWBBO5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWBBO5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 09:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWBBO5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 09:57:23 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:64543 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751113AbWBBO5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 09:57:22 -0500
Date: Thu, 2 Feb 2006 15:57:20 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Olaf Hering <olh@suse.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce __iowrite32_copy
Message-ID: <20060202145720.GE22815@osiris.boeblingen.de.ibm.com>
References: <200602011820.k11IKUBo024575@hera.kernel.org> <20060202142917.GA10870@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202142917.GA10870@suse.de>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> lib/iomap_copy.c: In function '__iowrite32_copy':
> lib/iomap_copy.c:40: error: implicit declaration of function '__raw_writel'
> 
> We compile with -Werror-implicit-function-declaration, and s390 does not
> have a __raw_writel.
> Should it just define __raw_writel to writel, like uml does a few
> commits later?

I sent a patch which fixes this for s390 earlier today.
http://lkml.org/lkml/2006/2/2/78

Thanks,
Heiko
