Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbULFX62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbULFX62 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbULFX62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:58:28 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:3005 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261703AbULFX6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:58:24 -0500
References: <20041206205305.GA11970@soohrt.org> <20041206134849.498bfc93.davem@davemloft.net> <20041206224107.GA8529@soohrt.org>
Message-ID: <cone.1102377418.20012.4626.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Karsten Desler <kdesler@soohrt.org>
Cc: David =?ISO-8859-1?B?Uy4=?= Miller <davem@davemloft.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Date: Tue, 07 Dec 2004 10:56:58 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Desler writes:

> * David S. Miller wrote:
>> It's spending nearly half of it's time in iptables.
>> Try to consolidate your rules if possible.  This is the
>> part of netfilter that really doesn't scale well at all.
>> 
> 
> Removing the iptables rules helps reducing the load a little, but the
> majority of time is still spent somewhere else.

I had a similar scenario recently with a very low spec box and found it to 
be the QoS. Disabling traffic shaping and removing the QoS modules made it 
much faster. I don't know if you're using them but it's worth pointing out.

Cheers,
Con

