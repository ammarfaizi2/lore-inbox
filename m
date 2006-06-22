Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWFVQFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWFVQFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbWFVQFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:05:05 -0400
Received: from xenotime.net ([66.160.160.81]:29162 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161076AbWFVQFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:05:04 -0400
Date: Thu, 22 Jun 2006 09:07:46 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] CRC ITU-T V.41
Message-Id: <20060622090746.5233bff5.rdunlap@xenotime.net>
In-Reply-To: <200606221629.05406.IvDoorn@gmail.com>
References: <200606221629.05406.IvDoorn@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 16:29:02 +0200 Ivo van Doorn wrote:

> diff --git a/lib/crc-itu-t.c b/lib/crc-itu-t.c
> new file mode 100644
> index 0000000..15128ae
> --- /dev/null
> +++ b/lib/crc-itu-t.c
> @@ -0,0 +1,69 @@
> +/*
> + *      crc-itu-t.c
> + *
> + * This source code is licensed under the GNU General Public License,
> + * Version 2. See the file COPYING for more details.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/crc-itu-t.h>
> +
> +/**
> + * crc_itu_t - Compute the CRC-ITU-T for the data buffer
> + *

no blank ('*') line here (above), please.
kernel-doc doesn't expect that.

> + * @crc: previous CRC value
> + * @buffer: data pointer
> + * @len: number of bytes in the buffer
> + *
> + * Returns the updated CRC value
> + */
> +u16 crc_itu_t(u16 crc, const u8 *buffer, size_t len)
> +{
> +	while (len--)
> +		crc = crc_itu_t_byte(crc, *buffer++);
> +	return crc;
> +}

---
~Randy
