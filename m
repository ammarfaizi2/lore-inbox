Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbUBTRXc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 12:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUBTRXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 12:23:32 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:49285 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261350AbUBTRXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 12:23:30 -0500
Date: Fri, 20 Feb 2004 12:14:27 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christophe Saout <christophe@saout.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040220171427.GD9266@certainkey.com>
References: <20040219170228.GA10483@leto.cs.pocnet.net> <20040219111835.192d2741.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219111835.192d2741.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 11:18:35AM -0800, Andrew Morton wrote:
> Christophe Saout <christophe@saout.de> wrote:
> >
> > Hello,
> > 
> > since some people keep complaining that the IV generation mechanisms
> > supplied in cryptoloop (and now dm-crypt) are insecure, which they
> > somewhat are, I just hacked a small digest based IV generation mechanism.
> > 
> > It simply hashes the sector number and the key and uses it as IV.
> > 
> > You can specify the encryption mode as "cipher-digest" like aes-md5 or
> > serpent-sha1 or some other combination.

As for naming the cipher-hash as "aes-sha256", why not just go all the way
and specify the mode of operation as well?

cipher-hash-modeop example: aes-sha256-cbc

As for hashing the hey etc.  You should be using HMAC for that.
  Christophe - would you like to change your patch to use HMACs?
  http://www.faqs.org/rfcs/rfc2104.html

Cheers,

JLC

> hmm.
> 
> > Consider this as a proposal, I'm not a crypto expert.
> 
> Me either.  But I believe that there are crypto-savvy people reading this
> list.  Help would be appreciated.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
