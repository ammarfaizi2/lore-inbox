Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUJGNVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUJGNVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUJGNVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:21:16 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:18317 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S264997AbUJGNT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:19:26 -0400
Date: Thu, 7 Oct 2004 14:19:04 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@hibernia.jakma.org
To: Martijn Sipkema <msipkema@sipkema-digital.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "David S. Miller" <davem@davemloft.net>, joris@eljakim.nl,
       linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <001c01c4ac76$fb9fd190$161b14ac@boromir>
Message-ID: <Pine.LNX.4.61.0410071413050.304@hibernia.jakma.org>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
 <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
 <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
 <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com>
 <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir>
 <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Martijn Sipkema wrote:

> Would you care to provide any real answers or are you just telling
> me to shut up because whatever Linux does is good, and not appear
> unreasonable by adding a ;) ..?

No, I'm saying it's simple good practice to set O_NONBLOCK on sockets 
if one expects not to block - any other expectation is not robust, 
never mind what POSIX says about select().

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
You know you are getting old when you think you should drive the speed limit.
 		-- E.A. Gilliam
