Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbTFQWWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264972AbTFQWWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:22:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29844 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264966AbTFQWU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:20:26 -0400
Message-ID: <3EEF9762.2040900@pobox.com>
Date: Tue, 17 Jun 2003 18:34:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCHES] 2.4.x net driver updates
References: <20030612194926.GA7653@gtf.org> <20030617222750.GE13990@werewolf.able.es>
In-Reply-To: <20030617222750.GE13990@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 06.12, Jeff Garzik wrote:
> 
>>BK users may issue a
>>
>>	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.4
>>
>>Others may download the patch from
>>
>>ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.21-rc8-netdrvr2.patch.bz2
>>
> 
> 
> Any info about the RX_POLLING (NAPI) option for e1000 ?
> What is that for ?


NAPI enables a software polling mode, or software interrupt migitation 
if you prefer to call it that.  It kicks in at moderate to high packet 
rates, allows the net stack to more globally balance net traffic, and 
avoids problems associated with high packet load / DoS situations which 
would otherwise max out a cpu.

But it's a new feature, so being conservative there is a staged rollout, 
with NAPI support in e100[0] being an option that can be turned off. 
Some drivers like tg3 simply always enable NAPI.

	Jeff


