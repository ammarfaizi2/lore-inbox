Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266666AbUFWVEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUFWVEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUFWVEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:04:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:11674 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266666AbUFWVED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:04:03 -0400
Date: Wed, 23 Jun 2004 14:06:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: FabF <fabian.frederick@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.7-mm1] MBR centralization
Message-Id: <20040623140650.46f184bd.akpm@osdl.org>
In-Reply-To: <1088025348.2213.32.camel@localhost.localdomain>
References: <1088025348.2213.32.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF <fabian.frederick@skynet.be> wrote:
>
> +/*Master boot record magic numbers*/
> +#define MSDOS_MBR_SIGNATURE 0xaa55
> +#define MSDOS_MBR(p) le16_to_cpu((u16)*p) == MSDOS_MBR_SIGNATURE

I'd make this

/*
 * Check for MSDOS Master Boot Record signature
 */
static inline int msdos_mbr(u16 v)
{
	return le16_to_cpu(v) == 0xaa55;
}
