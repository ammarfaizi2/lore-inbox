Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266408AbSKGF6f>; Thu, 7 Nov 2002 00:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266410AbSKGF6e>; Thu, 7 Nov 2002 00:58:34 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:61970 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266408AbSKGF6c>;
	Thu, 7 Nov 2002 00:58:32 -0500
Date: Wed, 6 Nov 2002 22:01:02 -0800
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pnp.h changes - 2.5.46 (4/6)
Message-ID: <20021107060102.GB26821@kroah.com>
References: <20021106210639.GO316@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106210639.GO316@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 09:06:39PM +0000, Adam Belay wrote:
>  
> +static inline void *pnp_get_drvdata (struct pnp_dev *pdev)
> +{
> +	return pdev->dev.driver_data;
> +}
> +
> +static inline void pnp_set_drvdata (struct pnp_dev *pdev, void *data)
> +{
> +	pdev->dev.driver_data = data;
> +}
> +
> +static inline void *pnp_get_protodata (struct pnp_dev *pdev)
> +{
> +	return pdev->protocol_data;
> +}
> +
> +static inline void pnp_set_protodata (struct pnp_dev *pdev, void *data)
> +{
> +	pdev->protocol_data = data;
> +}

Any reason for not just using dev_get_drvdata() and dev_set_drvdata() in
the drivers?  Or at the least, use them within these functions, that's
what they are there for :)

thanks,

greg k-h
