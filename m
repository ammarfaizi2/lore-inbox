Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSIEBvn>; Wed, 4 Sep 2002 21:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSIEBvn>; Wed, 4 Sep 2002 21:51:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47885 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316595AbSIEBvm>;
	Wed, 4 Sep 2002 21:51:42 -0400
Message-ID: <3D76B9BF.5080101@mandrakesoft.com>
Date: Wed, 04 Sep 2002 21:56:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
CC: linux.nics@intel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre5 e100 build error + trivial fix
References: <3D769371.6000009@domdv.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:
> Hi,
> the e100 driver in 2.4.20pre5 fails to build due to a static procedure 
> declaration with an unresolved symbol (see below), trivial patch to fix 
> this is attached.
> ------------------------------------------------------------------------
> 
> --- drivers/net/e100/e100_phy.c.orig	2002-09-05 00:35:38.000000000 +0200
> +++ drivers/net/e100/e100_phy.c	2002-09-05 01:03:32.000000000 +0200
> @@ -622,7 +622,7 @@
>   * Returns: void
>   *
>   */
> -static void
> +void
>  e100_force_speed_duplex(struct e100_private *bdp)
>  {
>  	u16 control;


This is already sent to Marcelo for 2.4.x...

