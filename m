Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbUL3Nja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUL3Nja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 08:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbUL3Nhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 08:37:34 -0500
Received: from relay.axxeo.de ([213.239.199.237]:37810 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261642AbUL3NgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 08:36:15 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.10 1/22] xfrm: Add direction information to xfrm_state
Date: Thu, 30 Dec 2004 14:36:06 +0100
User-Agent: KMail/1.6.2
References: <20041230035000.01@ori.thedillows.org> <20041230035000.10@ori.thedillows.org>
In-Reply-To: <20041230035000.10@ori.thedillows.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200412301436.06653.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I'm happy to see a framework and example driver for this.

David Dillow schrieb:
> diff -Nru a/include/net/xfrm.h b/include/net/xfrm.h
> --- a/include/net/xfrm.h 2004-12-30 01:12:08 -05:00
> +++ b/include/net/xfrm.h 2004-12-30 01:12:08 -05:00
> @@ -194,6 +203,7 @@
>   struct xfrm_state *(*find_acq)(u8 mode, u32 reqid, u8 proto,
>            xfrm_address_t *daddr, xfrm_address_t *saddr,
>            int create);
> + void   (*map_direction)(struct xfrm_state *xfrm);
>  };
>

Please don't build modifiers, but build functions instead.

e.g. 

xfrm->direction = map_direction(xfrm)

That way you don't hide the assignment and thus code becomes much clearer and
can be called multiple times without risk.


Regards

Ingo Oeser

