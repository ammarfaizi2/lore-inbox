Return-Path: <linux-kernel-owner+w=401wt.eu-S1161041AbWLTXzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWLTXzm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbWLTXzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:55:42 -0500
Received: from palrel11.hp.com ([156.153.255.246]:34094 "EHLO palrel11.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161034AbWLTXzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:55:41 -0500
X-Greylist: delayed 1075 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 18:55:41 EST
Message-ID: <4589C945.3050105@hp.com>
Date: Wed, 20 Dec 2006 15:37:41 -0800
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.7.13) Gecko/20060601
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network drivers that don't suspend on interface down
References: <20061219185223.GA13256@srcf.ucam.org>	<200612191959.43019.david-b@pacbell.net>	<20061220042648.GA19814@srcf.ucam.org>	<200612192114.49920.david-b@pacbell.net>	<20061220053417.GA29877@suse.de>	<20061220055209.GA20483@srcf.ucam.org>	<1166601025.3365.1345.camel@laptopd505.fenrus.org>	<20061220125314.GA24188@srcf.ucam.org>	<1166621931.3365.1384.camel@laptopd505.fenrus.org>	<20061220143134.GA25462@srcf.ucam.org>	<1166629900.3365.1428.camel@laptopd505.fenrus.org> <20061220144906.7863bcd3@dxpl.pdx.osdl.net>
In-Reply-To: <20061220144906.7863bcd3@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are two different problems:
> 
> 1) Behavior seems to be different depending on device driver
>    author. We should document the expected semantics better.
> 
>    IMHO:
> 	When device is down, it should:
> 	 a) use as few resources as possible:
> 	       - not grab memory for buffers
> 	       - not assign IRQ unless it could get one
> 	       - turn off all power consumption possible
> 	 b) allow setting parameters like speed/duplex/autonegotiation,
>             ring buffers, ... with ethtool, and remember the state
> 	 c) not accept data coming in, and drop packets queued

What implications does c have for something like tcpdump?

rick jones
