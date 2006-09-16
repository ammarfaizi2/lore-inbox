Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWIPMNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWIPMNm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 08:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWIPMNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 08:13:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:31918 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964790AbWIPMNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 08:13:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mFy7FeLT+fmVWFF2D8ael7vEIJHwk9Tu8FOJXcZ6BsOmbAo3IoisoIvYe1SC5PqU4nyL+qLrAPo3Nja8WnKDilpN9TDxfirqXFXjB/Zdb1zrU8/QNDFTnoGmX9N//0YtSrflCpxPgNg2039MKzz+C+aHd+tY4gOZWPgx3wIrZZw=
Message-ID: <a885b78b0609160513y39adbd72nf9502da7a96e59ce@mail.gmail.com>
Date: Sat, 16 Sep 2006 20:13:40 +0800
From: "xixi lii" <xixi.limeng@gmail.com>
To: davids@webmaster.com
Subject: Re: UDP question.
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEDAOHAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a885b78b0609151702r3b4086c4l3bb79c2e5c9ddf4a@mail.gmail.com>
	 <MDEHLPKNGKAHNMBLJOLKAEDAOHAB.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/9/16, David Schwartz <davids@webmaster.com>:
>
> > Let me explain my network environment, My program is running on a two
> > adapters machine, whose IP is 192.168.0.1/8 and 192.168.0.2/8, then,
> > my destination is two machine, whose IP is 192.168.0.3/8 and
> > 192.168.0.4/8. I use four 100M exchange and a 1000M exchange cennected
> > them to ensure the choke point is not at network  equipment.
>
> So both interfaces are part of the same network, and the machines are not
> connected to the Internet? (The host ns4.bbn.com is 192.1.122.13, for
> example.)
>
> > when I use two socket without bonding, one socket is bind
> > 192.168.0.1/8 and sendto 192.168.0.3/8, the other is bind
> > 192.168.0.2/8 and sendto 192.168.0.4/8, but, as you see, I get a
> > result that the speed of send by two adapters is equal to the only one
> > adapter's.
>
> None of your code gives the kernel any reason to prefer one interface over
> the other. Why would an interface bound to 192.168.0.1 be better than one
> for 192.168.0.2 if you're sending to 192.168.0.3?
>
> > yesterday. I got an uncertain idea, is the problem that IP layer is
> > separate with Eth layer ? when I bind src IP, it just do helpful to IP
> > layer, not real bind the adapter? when I send, the real ethreal
> > adapter is select by IP route? If the two interface can go
> > destinnation both, IP layer will choose the frist, not use both? Am I
> > right?
>
> Correct, you are binding to the adapter's address, not to the adapter. The
> IP routing layer still determines which interface a packet is transmitted
> on.
>
> > If so, when I use bonding, the adapter's physical address is the frist
> > one, Do this means that all of the packet come to my machine will go
> > through in the frist one adapter?
>
> It depends how you have the IP routing layer configured. You can configure
> it to select the adapter based on the source address if you want to.

then how do I configure this?
>
> DS
>
>
>
