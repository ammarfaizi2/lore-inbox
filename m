Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319217AbSILXon>; Thu, 12 Sep 2002 19:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319228AbSILXom>; Thu, 12 Sep 2002 19:44:42 -0400
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:21633 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S319217AbSILXok>;
	Thu, 12 Sep 2002 19:44:40 -0400
Date: Thu, 12 Sep 2002 16:49:22 -0700
From: Simon Kirby <sim@netnation.com>
To: "David S. Miller" <davem@redhat.com>
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: 802.1q + device removal causing hang
Message-ID: <20020912234922.GA1472@netnation.com>
References: <20020911223252.GA12517@erik.ca> <20020911.153132.63843642.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911.153132.63843642.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 03:31:32PM -0700, David S. Miller wrote:

> Try this:
> 
> --- net/8021q/vlan.c.~1~	Wed Sep 11 15:34:49 2002
> +++ net/8021q/vlan.c	Wed Sep 11 15:34:59 2002
> @@ -626,7 +626,7 @@
>  			ret = unregister_vlan_dev(dev,
>  						  VLAN_DEV_INFO(vlandev)->vlan_id);
>  
> -			unregister_netdev(vlandev);
> +			unregister_netdevice(vlandev);
>  
>  			/* Group was destroyed? */
>  			if (ret == 1)

Woops, sorry about the erik.ca domain.

Yup, this fixed it!

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
