Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbUBYNEu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 08:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbUBYNEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 08:04:49 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:52631 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261284AbUBYNEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 08:04:46 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: PRD_ENTRIES is 256
Date: Wed, 25 Feb 2004 14:11:13 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20040225095317.GJ693@holomorphy.com>
In-Reply-To: <20040225095317.GJ693@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402251411.13945.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 of February 2004 10:53, William Lee Irwin III wrote:
> PRD_ENTRIES is specified to be precisely 256; on platforms where
> PAGE_SIZE varies from 4KB the calculation in the current expression
> defining it is inaccurate, which may cause crashes. This patch changes
> it to the constant literal 256.

Ok, thanks.  However I cannot find 256 entries limit in any ATA document
and from looking at the code 512 entries shouldn't be a problem (?).

--bart

> -- wli
>
>
> ===== include/linux/ide.h 1.88 vs edited =====
> --- 1.88/include/linux/ide.h	Tue Feb 10 07:35:39 2004
> +++ edited/include/linux/ide.h	Wed Feb 25 01:46:45 2004
> @@ -224,7 +224,7 @@
>   * allowing each to have about 256 entries (8 bytes each) from this.
>   */
>  #define PRD_BYTES       8
> -#define PRD_ENTRIES     (PAGE_SIZE / (2 * PRD_BYTES))
> +#define PRD_ENTRIES     256
>
>  /*
>   * Some more useful definitions

