Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287905AbSABTZU>; Wed, 2 Jan 2002 14:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287913AbSABTZL>; Wed, 2 Jan 2002 14:25:11 -0500
Received: from waste.org ([209.173.204.2]:60581 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S287905AbSABTYv>;
	Wed, 2 Jan 2002 14:24:51 -0500
Date: Wed, 2 Jan 2002 13:24:25 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: Extern variables in *.c files
In-Reply-To: <02010216180403.01928@manta>
Message-ID: <Pine.LNX.4.43.0201021322120.30079-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, vda wrote:

> I grepped kernel *.c (not *.h!) files for extern variable definitions.
> Much to my surprize, I found ~1500 such defs.
>
> Isn't that bad C code style? What will happen if/when type of variable gets
> changed? (int->long).

Yes; Int->long won't change anything on 32-bit machines and will break
silently on 64-bit ones. The trick is finding appropriate places to put
such definitions so that all the things that need them can include them
without circular dependencies.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

