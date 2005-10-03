Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVJCSkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVJCSkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVJCSkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:40:01 -0400
Received: from [81.2.110.250] ([81.2.110.250]:49360 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751170AbVJCSkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:40:00 -0400
Subject: Re: [PATCH 6/7] AMD Geode GX/LX support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
In-Reply-To: <20051003180200.GH29264@cosmic.amd.com>
References: <20051003180200.GH29264@cosmic.amd.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 20:07:43 +0100
Message-Id: <1128366463.26992.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-03 at 12:02 -0600, Jordan Crouse wrote:
> +	u32 val;
> +
> +	val = *((u32 *) (geode_rng_base + GEODE_RNG_DATA_REG));
> +	return val;
> +}
> +
> +static unsigned int geode_data_present(void) {
> +	u32 val;
> +
> +	val = *((u32 *) (geode_rng_base + GEODE_RNG_STATUS_REG));
> +	return val;
> +}

ioremap space is not directly for reference evenif it happens to work
currently for this case - use readl

