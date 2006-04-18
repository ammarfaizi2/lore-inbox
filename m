Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWDRMWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWDRMWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 08:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWDRMWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 08:22:51 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:61458 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1750894AbWDRMWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 08:22:50 -0400
Date: Tue, 18 Apr 2006 21:25:25 +0900 (JST)
Message-Id: <20060418.212525.21076744.yoshfuji@linux-ipv6.org>
To: nicolas@boichat.ch
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       johannes@sipsolutions.net, stelian@popies.net,
       mactel-linux-devel@lists.sourceforge.net, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, frank@scirocco-5v-turbo.de,
       petero2@telia.com, linux-kernel@hansmi.ch, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] MacBook Pro touchpad support
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1145358431.14816.18.camel@localhost>
References: <1145358431.14816.18.camel@localhost>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1145358431.14816.18.camel@localhost> (at Tue, 18 Apr 2006 13:07:11 +0200), Nicolas Boichat <nicolas@boichat.ch> says:

> @@ -147,13 +164,22 @@ MODULE_PARM_DESC(debug, "Activate debugg
>  /* Checks if the device a Geyser 2 (ANSI, ISO, JIS) */
>  static inline int atp_is_geyser_2(struct atp *dev)
>  {
> -	int16_t productId = le16_to_cpu(dev->udev->descriptor.idProduct);
> +	int productId = le16_to_cpu(dev->udev->descriptor.idProduct);
>  
>  	return (productId == GEYSER_ANSI_PRODUCT_ID) ||
>  		(productId == GEYSER_ISO_PRODUCT_ID) ||
>  		(productId == GEYSER_JIS_PRODUCT_ID);
>  }

Any good reasons to change this?

>  
> +static inline int atp_is_geyser_3(struct atp *dev)
> +{
> +	int productId = le16_to_cpu(dev->udev->descriptor.idProduct);
> +
> +	return (productId == GEYSER3_ANSI_PRODUCT_ID) ||
> +		(productId == GEYSER3_ISO_PRODUCT_ID) ||
> +		(productId == GEYSER3_JIS_PRODUCT_ID);
> +}
> +
>  static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
>  			     int *z, int *fingers)
>  {

If no, use int16 productId.

--yoshfuji
