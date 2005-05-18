Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVERQN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVERQN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVERQCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:02:44 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:39807 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262328AbVERPzk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:55:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uOfq1AobFJDdj3khrryaBkIxBRIX87TVGVHOpjve9PwXOIo8rRxUR/8SjTjdETF9+TwgfH2OV4MrEOmL3JE0HLs/gNsUpD7MNEfXHzx7Oyv1/e3sU2Srft4vqEePydr8AVtYEK+l4REdCfqx7qYG+zr5FrM4qVZVDbRwGS7TN9U=
Message-ID: <5fc59ff305051808558f1ce59@mail.gmail.com>
Date: Wed, 18 May 2005 08:55:39 -0700
From: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Reply-To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] NUMA aware allocation of transmit and receive buffers for e1000
Cc: Christoph Lameter <christoph@lameter.com>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shai@scalex86.org
In-Reply-To: <20050517215845.2f87be2f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0505171854490.20408@graphe.net>
	 <20050517190343.2e57fdd7.akpm@osdl.org>
	 <Pine.LNX.4.62.0505171941340.21153@graphe.net>
	 <20050517.195703.104034854.davem@davemloft.net>
	 <Pine.LNX.4.62.0505172125210.22920@graphe.net>
	 <20050517215845.2f87be2f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/05, Andrew Morton <akpm@osdl.org> wrote:
> I think the e1000 driver is being a bit insane there.  I figure that
Do you mean insane to use vmalloc?

> sizeof(struct e1000_buffer) is 28 on 64-bit, so even with 4k pagesize we'll
> always succeed in being able to support a 32k/32 = 1024-entry Tx ring.
> 
> Is there any real-world reason for wanting larger ring sizes than that?
> 
> 
We have had cases where allocation of 32K of memory (via kmalloc) fails. 

ganesh.
