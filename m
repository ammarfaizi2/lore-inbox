Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269591AbUJGBRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269591AbUJGBRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 21:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269600AbUJGBRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 21:17:53 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:57227 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S269591AbUJGBRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 21:17:51 -0400
Date: Thu, 7 Oct 2004 02:16:34 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@hibernia.jakma.org
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: "David S. Miller" <davem@davemloft.net>, joris@eljakim.nl,
       linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
 <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
 <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, Richard B. Johnson wrote:

> thing --not. Select must return correct information.

It does, it's just state that select() reported on changed by the 
time user called recvmsg.

> When a function call like select() says there are data available, 
> there must be data available, period.

There was, but there wasnt when recvmsg() was called. Time changes 
things..

> If not, it's broken and needs to be fixed. Requiring one to set 
> sockets to non-blocking is a poor work- around for an otherwise 
> fatal flaw.

Any application that expects socket read not to block should set 
O_NONBLOCK.

> Cheers,
> Dick Johnson

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Kansas state law requires pedestrians crossing the highways at night to
wear tail lights.
