Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVE3OzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVE3OzA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVE3Ox0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:53:26 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:40543 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261621AbVE3Ovq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:51:46 -0400
Message-ID: <429B2880.7060608@tls.msk.ru>
Date: Mon, 30 May 2005 18:51:44 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: =?ISO-8859-1?Q?Gr=E9goire_Favre?= <gregoire.favre@gmail.com>,
       dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
References: <20050517192636.GB9121@gmail.com>	 <1116359432.4989.48.camel@mulgrave> <20050517195650.GC9121@gmail.com>	 <1116363971.4989.51.camel@mulgrave> <20050521232220.GD28654@gmail.com>	 <1116770040.5002.13.camel@mulgrave> <20050524153930.GA10911@gmail.com>	 <1117113563.4967.17.camel@mulgrave> <20050526143516.GA9593@gmail.com>	 <1117118766.4967.22.camel@mulgrave>  <20050526173518.GA9132@gmail.com> <1117463938.4913.3.camel@mulgrave>
In-Reply-To: <1117463938.4913.3.camel@mulgrave>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
[]
> diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
> --- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
> +++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
> @@ -735,6 +735,7 @@ ahc_linux_slave_configure(struct scsi_de
>  
>  	/* Initial Domain Validation */
>  	if (!spi_initial_dv(device->sdev_target))
> +		spi_min_period(device->sdev_target) = 100;
>  		spi_dv_device(device);

Hmm.. Should there be a pair of {}'s somewhere?

/mjt
