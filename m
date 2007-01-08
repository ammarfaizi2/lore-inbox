Return-Path: <linux-kernel-owner+w=401wt.eu-S1030502AbXAHE1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbXAHE1c (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 23:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbXAHE1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 23:27:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:38701 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030502AbXAHE1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 23:27:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=Q/rJzrrFie8jy2B5248JOcqc10QNVWCH6jznB6L/UODosXQrXAAhxUsZCVayK3leb4dB7k+/yW7rYBEx/KpvGnt9SXNLKqprWENvUbOawrKhj1cm+GlHtd1oZ9DA/k5BZ/aRZRY4zK6y/jc8ShnSbapr+E+JfhG1oB+NdEvoQPI=
Date: Mon, 8 Jan 2007 06:26:57 +0200
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] UCC Ether driver: kmalloc casting cleanups
Message-ID: <20070108042657.GA18610@Ahmed>
Mail-Followup-To: Li Yang-r58472 <LeoLi@freescale.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20070106131832.GE19020@Ahmed> <989B956029373F45A0B8AF029708189006134E@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <989B956029373F45A0B8AF029708189006134E@zch01exm26.fsl.freescale.net>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 11:12:28AM +0800, Li Yang-r58472 wrote:
> > From: Ahmed S. Darwish [mailto:darwish.07@gmail.com]
> > 
> > Hi,
> > A kmalloc casting cleanup patch.
> > Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>

[..]

> > -				(u32) (kmalloc((u32) (length + align),
> > -				GFP_KERNEL));
> > +				kmalloc((u32) (length + align), GFP_KERNEL);
> > +
> >  			if (ugeth->tx_bd_ring_offset[j] != 0)
> >  				ugeth->p_tx_bd_ring[j] =

[..]

> > -			    (u32) (kmalloc((u32) (length + align), GFP_KERNEL));
> > +				kmalloc((u32) (length + align), GFP_KERNEL);
> 
> NACK about the 2 clean-ups above.  Cast from pointer to integer is
> required here.

Are the casts from pointer to integer just needed to suppress gcc 
warnings or there's something technically important about them ?

I'll send the modified patch without the NACKed parts in minutes ..

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
