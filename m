Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUAYXp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUAYXp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:45:59 -0500
Received: from mail.cyberus.ca ([209.197.145.21]:16105 "EHLO mail.cyberus.ca")
	by vger.kernel.org with ESMTP id S263620AbUAYXp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:45:57 -0500
Subject: Re: [RFC/PATCH] IMQ port to 2.6
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20040125202148.GA10599@usr.lcm.msu.ru>
References: <20040125152419.GA3208@penguin.localdomain>
	 <20040125164431.GA31548@louise.pinerecords.com>
	 <1075058539.1747.92.camel@jzny.localdomain>
	 <20040125202148.GA10599@usr.lcm.msu.ru>
Content-Type: text/plain
Organization: jamalopolis
Message-Id: <1075074316.1747.115.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Jan 2004 18:45:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-25 at 15:21, Vladimir B. Savkin wrote:
> On Sun, Jan 25, 2004 at 02:22:19PM -0500, jamal wrote:

> Think multiple clients connected via PPP. I want to shape traffic,
> so ingress is out of question. I want different clients in a same

Ok, 
a) why do you want to shape on ingress instead of policing?
OR
b) Why cant you achieve the same results by marking on ingress and
shaping on egress? 

> htb class, so using qdisc on each ppp interface is out of
> question. It seems to me that IMQ is the only way to achieve my goals.

By multiple clients i believe you mean you want to say "-i ppp+"?
We had a long discussion on this a while back (search netdev) 
and i think it is a valid point for dynamic devices like ppp. 
We need to rethink how we do things. Theres a lot of valu in having per
device tables (scalability being one).
IMO, this alone does not justify the existence of IMQ. 
We should do this (and other things) right, maybe a sync with the
netfilter folks will be the right thing to do. 

cheers,
jamal

