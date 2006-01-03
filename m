Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWACUfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWACUfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWACUfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:35:22 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:63408 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932476AbWACUfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:35:19 -0500
Message-ID: <43BADFB3.5050908@colorfullife.com>
Date: Tue, 03 Jan 2006 21:33:55 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ayaz Abdulla <aabdulla@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, manfred@dbl.q-ag.de,
       jgarzik@pobox.com, afu@fugmann.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] forcedeth: TSO fix for large buffers
References: <200512251451.jBPEpgNe018712@dbl.q-ag.de> <20051225.125742.65007619.davem@davemloft.net> <3E346722.7070304@nvidia.com>
In-Reply-To: <3E346722.7070304@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ayaz Abdulla wrote:

> If you look at the code, I do not set the NV_TX2_VALID bit (stored in 
> np->tx_flags) in the first tx descriptor

You are right: tx_flags starts as 0 and is only set to np->tx_flags 
after the first tx descriptor was set up.
I overlooked that point, sorry.

Jeff: Could you add the patch to your tree?

--
    Manfred
