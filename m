Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSKLPCu>; Tue, 12 Nov 2002 10:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSKLPCu>; Tue, 12 Nov 2002 10:02:50 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:13257 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S261609AbSKLPCs>; Tue, 12 Nov 2002 10:02:48 -0500
Date: Tue, 12 Nov 2002 08:09:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] Have split-include take another argument
Message-ID: <20021112150932.GE658@opus.bloom.county>
References: <20021111170604.GA658@opus.bloom.county> <20021111233710.GR4182@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021111233710.GR4182@cadcamlab.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 05:37:10PM -0600, Peter Samuelson wrote:
 
> [Tom Rini]
> > First, does anyone see any problems with the patch itself?
> 
> Well,
> 
> > -	str_config += sizeof("CONFIG_") - 1;
> > +	str_config += strlen(str_split_token);
> 
> it does seem a bit inefficient to call strlen() for every single line
> of every single source file.  Perhaps today's compilers know that
> strlen() is invariant and has no side effects, but I vote you go ahead
> and optimise it explicitly.

Sounds good, thanks.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
