Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVC2PDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVC2PDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 10:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVC2PDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 10:03:32 -0500
Received: from colin2.muc.de ([193.149.48.15]:24842 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262249AbVC2PD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 10:03:27 -0500
Date: 29 Mar 2005 17:03:25 +0200
Date: Tue, 29 Mar 2005 17:03:25 +0200
From: Andi Kleen <ak@muc.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: folkert@vanheusden.com, Andrew Morton <akpm@osdl.org>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329150325.GA63268@muc.de>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org> <m1y8cc3mj1.fsf@muc.de> <424324F1.8040707@pobox.com> <20050327171934.GB18506@muc.de> <20050327185500.GP943@vanheusden.com> <20050328152043.GA26121@muc.de> <42490104.8040302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42490104.8040302@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 02:17:24AM -0500, Jeff Garzik wrote:
> Andi Kleen wrote:
> >BTW what do you do when the FIPS test fails? I dont see a good fallback
> >path for this case.
> 
> If the FIPS test fails, do the obvious:  don't feed that data to the 
> kernel (and credit entropy), and possibly stop using the hardware RNG 

This will just cause hangs; basically it is a DOS. 

> under a human has intervened.
> 
> This is not rocket science.  The fallback path is "use software", which 
> is what most users do right now anyway.

Just that use software does not work on a headless machine sitting
in a rack with not much disk IO. 

-Andi
