Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTIJBMR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 21:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbTIJBMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 21:12:17 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:48577 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264286AbTIJBMQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 21:12:16 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] pdc4030: return needs value; function needs return;
Date: Wed, 10 Sep 2003 03:14:26 +0200
User-Agent: KMail/1.5
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
References: <20030909165414.2f0a5113.rddunlap@osdl.org>
In-Reply-To: <20030909165414.2f0a5113.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309100314.26305.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Wednesday 10 of September 2003 01:54, Randy.Dunlap wrote:
> @@ -317,7 +317,7 @@ int __init ide_probe_for_pdc4030(void)
>  #endif
>  		}
>  	}
> -#ifdef MODULE
> +#ifndef MODULE
>  	return 0;
>  #endif
>  }

This is wrong, we will now get warning for module instead of built-in.
Proper fix is to remove this #ifdef.

--bartlomiej

