Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbTI3L2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 07:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbTI3L2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 07:28:35 -0400
Received: from [62.197.173.195] ([62.197.173.195]:11400 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261313AbTI3L2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 07:28:33 -0400
Date: Tue, 30 Sep 2003 14:28:30 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Rogier Wolff <Swen-Trap1@BitWizard.nl>,
       Artur Klauser <Artur.Klauser@computer.org>,
       linux-kernel@vger.kernel.org
Subject: Re: div64.h:do_div() bug
Message-ID: <20030930112830.GK1058@mea-ext.zmailer.org>
References: <Pine.LNX.4.51.0309291503030.7947@enm.xynhfre.bet> <20030930095229.GA32421@bitwizard.nl> <20030930101438.GJ1058@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930101438.GJ1058@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 01:14:38PM +0300, Matti Aarnio wrote:
> On Tue, Sep 30, 2003 at 11:52:29AM +0200, Rogier Wolff wrote:
> > On Mon, Sep 29, 2003 at 03:25:19PM +0200, Artur Klauser wrote:
> > > I've found that a bug in asm-arm/div64.h:do_div() is preventing correct
> > > conversion of timestamps in smbfs (and probably ntfs as well) from NT to
> > 
> > Nope. 
> 
>   Nope yourself.
> 
> > >   if (in.n64 != out.n64) {
> > >     printf("FAILURE: asm/div64.h:do_div() is broken for 64-bit dividends\n");
> > 
> > do_div should be/is documented as not doing 64 bit dividents. It does
> > 64/32 -> 32 divides, IIRC... 
> 
>   64/32 -> 64,32
> 
> The REMAINDER is 32 bit value.

Non-native english speaker makes the mistake..  MODULUS is 32 bits as is
DIVISOR, REMAINDER is 64 bit, as is DIVIDEND.

That is:
	DIVIDEND / DIVISOR -> REMAINDER , MODULUS

and
	REMAINDER * DIVISOR + MODULUS = DIVIDEND

> > 		Roger. 
 
/Matti Aarnio
