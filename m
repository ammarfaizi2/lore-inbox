Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWDJWv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWDJWv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWDJWv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:51:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39133 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932159AbWDJWvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:51:25 -0400
Date: Mon, 10 Apr 2006 14:50:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/7] tpm: chip struct update
Message-Id: <20060410145030.0b719e18.akpm@osdl.org>
In-Reply-To: <1144679828.4917.11.camel@localhost.localdomain>
References: <1144679828.4917.11.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall <kjhall@us.ibm.com> wrote:
>
> +	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES] &=
>  +	    ~(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));

If you were to make dev_mask[] an array of longs, this could perhaps become

	clear_bit(dev_mask, chip->dev_num);

