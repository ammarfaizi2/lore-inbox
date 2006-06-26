Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWFZXjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWFZXjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933206AbWFZXjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:39:20 -0400
Received: from stinky.trash.net ([213.144.137.162]:30404 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S933280AbWFZXiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:38:52 -0400
Message-ID: <44A0700A.8090600@trash.net>
Date: Tue, 27 Jun 2006 01:38:50 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dlezcano@fr.ibm.com
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [RFC] [patch 0/6] [Network namespace] introduction
References: <20060609210202.215291000@localhost.localdomain>
In-Reply-To: <20060609210202.215291000@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dlezcano@fr.ibm.com wrote:
> What is missing ?
> -----------------
> The routes are not yet isolated, that implies:
> 
>    - binding to another container's address is allowed
> 
>    - an outgoing packet which has an unset source address can
>      potentially get another container's address
> 
>    - an incoming packet can be routed to the wrong container if there
>      are several containers listening to the same addr:port

Does that mean that identification of containers for incoming packets
is done by IP address through routing (just had a quick look at the
patches, if I missed something obvious please just point me to it)?
How is code that uses global data without verifying its presence
(and visibility in the container) at initialization time going to be
handled? Netfilter and I think the TC action code contain some examples
for this.

