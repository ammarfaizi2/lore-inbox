Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUFLGsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUFLGsr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 02:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbUFLGsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 02:48:47 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:50955 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264658AbUFLGsq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 02:48:46 -0400
Date: Sat, 12 Jun 2004 16:45:00 +1000
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Pavel Machek <pavel@suse.cz>, mochel@digitalimplant.org,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: Fix memory leak in swsusp
Message-ID: <20040612064500.GA17349@gondor.apana.org.au>
References: <20040609130451.GA23107@elf.ucw.cz> <E1BYN8O-0008Vg-00@gondolin.me.apana.org.au> <20040610105629.GA367@gondor.apana.org.au> <20040610212448.GD6634@elf.ucw.cz> <20040610233707.GA4741@gondor.apana.org.au> <20040611094844.GC13834@elf.ucw.cz> <20040611101655.GA8208@gondor.apana.org.au> <20040611102327.GF13834@elf.ucw.cz> <20040611110314.GA8592@gondor.apana.org.au> <40CA75CA.2030209@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40CA75CA.2030209@linuxmail.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2004 at 01:17:30PM +1000, Nigel Cunningham wrote:
> 
> We were avoiding the use of memcpy because it messes up the preempt count 
> with 3DNow, and potentially as other unseen side effects. The preempt could 
> possibly simply be reset at resume time, but the point remains.

In what way does it mess up the preempt count?
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
