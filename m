Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWIPACI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWIPACI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 20:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWIPACI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 20:02:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:15006 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932240AbWIPACG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 20:02:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qpTJt7xioJy+XHfB3gPH8SMgrS5u3H0SFem0SgRxy2+jXgJLaV/dsBs0EhRewmfRDmjvxtjGV8EM10TTKb3jVWo1e1Di2K3sqRVQCVGKIse9YPwiR2bJxA8x4OuRjVCJo+HB0LbdBLomuCaW3j3o4OeK34lqdQQkNWbvA/hYRmQ=
Message-ID: <a885b78b0609151702r3b4086c4l3bb79c2e5c9ddf4a@mail.gmail.com>
Date: Sat, 16 Sep 2006 08:02:04 +0800
From: "xixi lii" <xixi.limeng@gmail.com>
To: davids@webmaster.com
Subject: Re: UDP question.
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGECFOHAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a885b78b0609150007u239cf363l40dd122165f7b516@mail.gmail.com>
	 <MDEHLPKNGKAHNMBLJOLKGECFOHAB.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/9/16, David Schwartz <davids@webmaster.com>:
>
> > My two adapters has two different IP address, and I bind one IP
> > on one socket,
> > do you mean that I alloc two socket and bind different IP is not
> > helpful?
>
>        Correct. You are still sending all the packets *to* the same place.
>
> > In fact, all the packet sent from two socket is go out by one
> > network adapter?
>
>        Yes, of course. Why would the kernel send traffic to a destination out an
> interface that doesn't go to that destination?
>
>        Suppose you have two interfaces, 1.2.3.4/8 and 10.2.3.4/8, if you are
> sending a packet *to* 1.2.4.5, it will go out the first interface. This
> applies whether the source address is 1.2.3.4 or 10.2.3.4.
>
>        By default, the kernel routes traffic based on where it is going, not which
> interface address it came from.
>
>        DS
>

Let me explain my network environment, My program is running on a two
adapters machine, whose IP is 192.168.0.1/8 and 192.168.0.2/8, then,
my destination is two machine, whose IP is 192.168.0.3/8 and
192.168.0.4/8. I use four 100M exchange and a 1000M exchange cennected
them to ensure the choke point is not at network  equipment.

when I use two socket without bonding, one socket is bind
192.168.0.1/8 and sendto 192.168.0.3/8, the other is bind
192.168.0.2/8 and sendto 192.168.0.4/8, but, as you see, I get a
result that the speed of send by two adapters is equal to the only one
adapter's.

yesterday. I got an uncertain idea, is the problem that IP layer is
separate with Eth layer ? when I bind src IP, it just do helpful to IP
layer, not real bind the adapter? when I send, the real ethreal
adapter is select by IP route? If the two interface can go
destinnation both, IP layer will choose the frist, not use both? Am I
right?

If so, when I use bonding, the adapter's physical address is the frist
one, Do this means that all of the packet come to my machine will go
through in the frist one adapter?

Thx all.
Best Regard.

xixi
