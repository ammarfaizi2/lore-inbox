Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbVIOLXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVIOLXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 07:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVIOLXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 07:23:44 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:11497 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750904AbVIOLXn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 07:23:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pbSgMHUH8WE6iWHMynsruh6zcBg8Do+vPiH6jj0klRbnA3zP0rMlEXsV9+L9HrIwKJo8JnJLPuuu4M2C36lo1Drqcc90r2sGXGSNaflk0lIy8q2ARDl0oDdoiC1rkhsr/kMITXJvsjl4fzytDaomOOP/njAvc3GhQC7g7bqfD8E=
Message-ID: <6278d22205091504232ac3d8c3@mail.gmail.com>
Date: Thu, 15 Sep 2005 12:23:37 +0100
From: Daniel J Blueman <daniel.blueman@gmail.com>
Reply-To: daniel.blueman@gmail.com
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: Help porting wireless InProComm IPN 2220 driver to 2.6
Cc: Runar Ingebrigtsen <runar@mopo.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43295825.90205@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6278d22205091503442c3973d4@mail.gmail.com>
	 <43295825.90205@domdv.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Andreas Steinmetz <ast@domdv.de> wrote:
> Daniel J Blueman wrote:
> > The file D-Link has made available contains either this or a
> > closed-source driver.
> 
> This is getting interesting. The tar archive contains a kernel source
> tree (looks like 2.4.26). This kernel source tree contains the directory:
> 
> linux-2.4.x/drivers/net/wireless/inpro2220
> 
> Within this directory there's the file IPN2220 which is a mips object
> file, so this is a binary only driver.
> 
> Now, even if this is built as a module the module "source" is imported
> in the kernel source tree, i.e. it is not separate from the kernel
> source. IMHO I do see this then as a GPL violation that goes beyond the
> Linus tolerated level.

This depends if the module uses any symbols exported from the kernel
with EXPORT_SYMBOL_GPL(), and clearly the module license - 'strings'
should be enough do check this is you don't have a MIPS platform to
hand.

See http://www.uwsg.iu.edu/hypermail/linux/kernel/0110.2/0369.html .
___
Daniel J Blueman
