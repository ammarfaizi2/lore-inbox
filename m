Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUG2M0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUG2M0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 08:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUG2MZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 08:25:46 -0400
Received: from host85.200-117-133.telecom.net.ar ([200.117.133.85]:29076 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S264519AbUG2MYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 08:24:23 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4, kallsyms_lookup, 2.6.7-mm7
Date: Thu, 29 Jul 2004 09:24:11 -0300
User-Agent: KMail/1.6.82
Cc: Guillaume POIRIER <guillaume.poirier@irisa.fr>
References: <200407281506.12876.norberto+linux-kernel@bensa.ath.cx> <4108C548.2020008@irisa.fr>
In-Reply-To: <4108C548.2020008@irisa.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407290924.11351.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume POIRIER wrote:
> Norberto Bensa wrote:
>  > Hello everyone,
>  >
>  > well, just out of curiosity (I wanted to play with reiser4) I've
>
> patched my 2.6.7-mm7 tree; no rejects. But I get this:
>  > *** Warning: "kallsyms_lookup" [fs/reiser4/reiser4.ko] undefined!
>  >
>  > How do I get around that warning?
>
> Is there any #include <linux/kallsyms.h>
> in any of the top files of this patch?

Yes, there's one on fs/reiser4/debug.c, which is the file referencing that 
function. 

I did a:

	EXPORT_SYMBOL(kallsyms_lookup);

in kernel/kallsyms.c and problem solved; I was looking for a better 
solution...

Many thanks,
Norberto
