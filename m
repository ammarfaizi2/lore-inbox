Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWHKAcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWHKAcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 20:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWHKAcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 20:32:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:23172 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932373AbWHKAcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 20:32:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=FB1q+VUmwOkxADAA0JCkgDceOFtEDqXnsNFr3LMELmOWLIiUyHR1VgYBROZaefmSBO6YlTIBlOYmczps4kSKaGei3/4vdaOhlpRmqmg+HwHnDHUKgDecp/85Fq0+NK9QR5ixpyTw+zsOEedAJD6rphKUnqDzytnWrgH0TgftMU8=
Date: Fri, 11 Aug 2006 04:32:04 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Cc: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev@vger.kernel.org,
       Thomas Klein <tklein@de.ibm.com>, linuxppc-dev@ozlabs.org,
       Christoph Raisch <raisch@de.ibm.com>, linux-kernel@vger.kernel.org,
       Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 3/6] ehea: queue management
Message-ID: <20060811003204.GA6935@martell.zuzino.mipt.ru>
References: <44D99F38.8010306@de.ibm.com> <20060811000540.200CE67B6B@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060811000540.200CE67B6B@ozlabs.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static inline u32 map_swqe_size(u8 swqe_enc_size)
> > +{
> > +	return 128 << swqe_enc_size;
> > +}		      ^
> > +		      |
> > +static inline u32|map_rwqe_size(u8 rwqe_enc_size)
> > +{		      |
> > +	return 128 << rwqe_enc_size;
		      ^
> > +}		      |
>		      |
> Snap!  These are ide|tical...
		      |
No, they aren't. -----+

> Name the function after what it does, not after the functions you expect
> to call it.

