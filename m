Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWACMTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWACMTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 07:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWACMTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 07:19:35 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:39222 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751386AbWACMTe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 07:19:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KHgwbWG58CvvDJohKqdczt6/SA8I4WliDZdJt4e8/GcyijRrjFctdv/rxzNzasS8eEBoGeCwn2ZnnPzszFv7El9Y1Y8rmEqIovACdv5aKbqdq5EcIkhm0hhdo0B/n3hT7LxWSy9nHhN8QB7ELZ2s3z+RQLYz5Xi4CLX5jB1zYfQ=
Message-ID: <6ec4247d0601030419w377fd396x@mail.gmail.com>
Date: Tue, 3 Jan 2006 22:49:33 +1030
From: Graham Gower <graham.gower@gmail.com>
To: Roger While <simrw@sim-basis.de>
Subject: Re: [PATCH] [TRIVIAL] prism54/islpci_eth.c: dev_kfree_skb in irq context
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <6.1.1.1.2.20060103105620.02c523e0@192.168.6.12>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6.1.1.1.2.20060103105620.02c523e0@192.168.6.12>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

012345678901234567890123456789012345678901234567890123456789

On 03/01/06, Roger While <simrw@sim-basis.de> wrote:
> What makes you think this is in IRQ context ?
>

Er... yeah. I must have been off my nut when I wrote that comment.
A more apt comment should perhaps have been "dev_kfree_skb shouldn't be
used with interrupts disabled". Forgive my noobness, I'm a kernel patch virgin.

My logs were starting to fill with messages exatcly like that mentioned here:
http://patchwork.netfilter.org/netfilter-devel/patch.pl?id=2840

In any event, the patch at the end of that link was never applied (it doesn't
fix the other call to dev_kfree_skb). After applying my patch, I've not had any
more messages in the logs.

Graham
