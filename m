Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312379AbSDJKT2>; Wed, 10 Apr 2002 06:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312392AbSDJKT1>; Wed, 10 Apr 2002 06:19:27 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.93]:29200 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S312379AbSDJKT1>; Wed, 10 Apr 2002 06:19:27 -0400
Date: Wed, 10 Apr 2002 11:19:13 +0100
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radeon frame buffer driver
Message-ID: <20020410101913.GA975@berserk.demon.co.uk>
Mail-Followup-To: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020410094055.GA789@berserk.demon.co.uk> <20020410105731.28774@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 11:57:31AM +0100, benh@kernel.crashing.org wrote:
> 
> Fine, though I noticed the get_cmap_len got changed to
> +	return var->bits_per_pixel == 8 ? 256 : 16;
> 

The colour map is only used by the kernel and the kernel only uses 16
entries so there isn't any reason to waste memory by making it any
larger. I checked a few other drivers and they do the same (aty128fb for
one).

P.
