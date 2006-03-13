Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWCMVuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWCMVuN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWCMVuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:50:13 -0500
Received: from palrel13.hp.com ([156.153.255.238]:14746 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S932471AbWCMVuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:50:11 -0500
Message-ID: <4415E911.8090504@hp.com>
Date: Mon, 13 Mar 2006 13:50:09 -0800
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Greg Scott <GregScott@InfraSupportEtc.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       Bart Samwel <bart@samwel.tk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Simon Mackinlay <smackinlay@mail.com>
Subject: Re: Router stops routing after changing MAC Address
References: <925A849792280C4E80C5461017A4B8A20321F5@mail733.InfraSupportEtc.com> <Pine.LNX.4.61.0603131636470.5608@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0603131636470.5608@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Anyway, if the device fails, you have
> routers and hosts ARPing the interface, trying to establish a
> route anyway.

But only after what may be a much longer time than the customer is 
willing to accept or able to configure.  I know of a number of HA 
situations where the "new" device is given the "old" MAC just to avoid 
that speicific situation of ARP caches not being updated except after 
quite some time.  Not necessarily on the end-systems, the issue can be 
with intermediate devices (routers).

And if one has to work with static ARP entries to deal (however 
imperfectly) with ARP poisioning or whatnot...

Indeed, there is a large onus on the software doing the MAC override to 
make sure it does not break the required uniqueness.  Just as if one 
were using locally administered MAC addresses.

rick jones
