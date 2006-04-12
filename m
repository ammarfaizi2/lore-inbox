Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWDLULu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWDLULu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 16:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWDLULu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 16:11:50 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:33771 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S932177AbWDLULt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 16:11:49 -0400
Message-ID: <443D5E9E.80002@candelatech.com>
Date: Wed, 12 Apr 2006 13:10:06 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: Ingo Oeser <netdev@axxeo.de>, Denis Vlasenko <vda@ilport.com.ua>,
       Dave Dillow <dave@thedillows.org>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [RFD][PATCH] typhoon and core sample for folding away VLAN stuff
References: <200604071628.30486.vda@ilport.com.ua> <200604111502.52302.vda@ilport.com.ua> <200604111517.37215.netdev@axxeo.de> <200604122132.46113.ioe-lkml@rameria.de>
In-Reply-To: <200604122132.46113.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the reasoning for this change?  Is the compiler
able to optomize the right-hand-side to a constant with your
change in place?

> -	if (veth->h_vlan_proto != __constant_htons(ETH_P_8021Q)) {
> +	if (veth->h_vlan_proto != htons(ETH_P_8021Q)) {
>  		return -EINVAL;
>  	}




-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

