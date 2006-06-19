Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWFSORO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWFSORO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 10:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWFSORO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 10:17:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:2518 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932445AbWFSORN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 10:17:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A6mw5bhykqwpNtLjRWv1Lm22s/5IcDO1GT97x8EcSG5OHNm0aX6MC4kAjVLyg+43XCoe0b5LpN9vWwqd4NGEpzuA80yC3VwE02BpOrEazKHOxXUiinXG6S6/2HUgBB1RyqukVKOm3x//V7dIy8HtHcjcDPj2k3w/H/IpwhBVZsw=
Message-ID: <65258a580606190717t2cc5b28eg10fb4d64fe5ec1f3@mail.gmail.com>
Date: Mon, 19 Jun 2006 16:17:12 +0200
From: "Vincent Vanackere" <vincent.vanackere@gmail.com>
To: "Brice Figureau" <brice+lklm@daysofwonder.com>
Subject: Re: 2.6.17: slow (as hell) tcp inbound transfers
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1150725598.4985.27.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1150725598.4985.27.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/06, Brice Figureau <brice+lklm@daysofwonder.com> wrote:
> Hi,
>
> First: please CC: me as I'm not subscribed to the list.
>
> Now to the problem: I just finished the installation of a brand new
> 2.6.17 on a Dell PowerEdge 2850 which was running 2.6.16.19 really fine,
> and I'm encountering a strange issue.
>
> It seems that TCP inbound transfers (using either curl, or scp) are
> really slow except when issued on our gigabit LAN.

Could you try the following to see if it cures your problem ?

echo 0 > /proc/sys/net/ipv4/tcp_window_scaling

Vincent
