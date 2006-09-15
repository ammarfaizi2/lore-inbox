Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWIOHHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWIOHHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 03:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWIOHHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 03:07:19 -0400
Received: from hu-out-0506.google.com ([72.14.214.230]:24909 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750926AbWIOHHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 03:07:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jVb/2sDx1AS7VyFPfOJYe57G4HeY3eGh4Qq6VReSGyd49PEcMraSCVeqSll/nWFYXDKc4oqUNhYCZa5xCNrB6wHEqxkt6W0V8SY0Blpc5KSvom4JKAERstkKVyeH05d68ZJuCE/cRZ+K2urffaXTZp0HsEKpYknx2Mo5gcQRlx0=
Message-ID: <a885b78b0609150007u239cf363l40dd122165f7b516@mail.gmail.com>
Date: Fri, 15 Sep 2006 15:07:15 +0800
From: "xixi lii" <xixi.limeng@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: UDP question.
Cc: "Sven-Haegar Koch" <haegar@sdinet.de>,
       Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0609150833170.19096@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a885b78b0609140900x385c9453n9ef25a936524dff7@mail.gmail.com>
	 <Pine.LNX.4.64.0609150129150.21941@mercury.sdinet.de>
	 <Pine.LNX.4.61.0609150833170.19096@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/9/15, Jan Engelhardt <jengelh@linux01.gwdg.de>:
>
> >> bind socket1.network adapter1...
> >> bind socket2 network adapter2
>
> > I am not really sure, but I think the bind to an adapter under linux only
> > chooses the source ip, not really the adapter used to send the packets.
>
> To explicitly send things through a specific interface, you need to use
> some magic, like PF_RAW. ping for example is one program that will do
> this (-I option).
>
> > Did you check that the two destination ips have routes through different
> > interfaces, and not go out through the same one?
>
> One cannot have the same subnet on multiple interfaces, because ARP
> queries will only be sent through the first one. You need br0 (or bond0
> - depending on how you plan to plan your network) to make them one
> interface.
>
>
> Jan Engelhardt
> --

My two adapters has two different IP address, and I bind one IP on one socket,
do you mean that I alloc two socket and bind different IP is not
helpful? In fact, all the packet sent from two socket is go out by one
network adapter?

xixi
