Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbQLTQfm>; Wed, 20 Dec 2000 11:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbQLTQfc>; Wed, 20 Dec 2000 11:35:32 -0500
Received: from fromage.dsndata.com ([198.183.6.16]:63242 "EHLO
	fromage.dsndata.com") by vger.kernel.org with ESMTP
	id <S129846AbQLTQfU>; Wed, 20 Dec 2000 11:35:20 -0500
Date: Wed, 20 Dec 2000 10:04:47 -0600
From: Jeff Epler <jepler@inetnebr.com>
To: Steve Grubb <ddata@gate.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] performance enhancement for simple_strtoul
Message-ID: <20001220100446.A1249@inetnebr.com>
In-Reply-To: <000e01c06a8e$6945db60$bc1a24cf@master>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <000e01c06a8e$6945db60$bc1a24cf@master>; from ddata@gate.net on Wed, Dec 20, 2000 at 09:09:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 09:09:03AM -0500, Steve Grubb wrote:
> Hello,
> 
> The following patch is a faster implementation of the simple_strtoul
> function.
[snip]

Why not preserve the existing code for bases other than 8, 10, and 16?
Admittedly, the only other case that is likely to be used would be base
2, but surely there's only a penalty of a few dozen bytes for the
following code..
> - while (isxdigit(*cp) && (value = isdigit(*cp) ? *cp-'0' : (islower(*cp)
> -     ? toupper(*cp) : *cp)-'A'+10) < base) {
> -  result = result*base + value;
> -  cp++;
> - }

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
