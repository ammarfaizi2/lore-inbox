Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVAOFPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVAOFPx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 00:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVAOFPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 00:15:52 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:7067 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262206AbVAOFO5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 00:14:57 -0500
Date: Sat, 15 Jan 2005 05:14:26 +0000 (UTC)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: Peter Buckingham <peter@pantasys.com>
cc: jyri.poldre@artecdesign.ee, linux-kernel@vger.kernel.org
Subject: Re: Ethernet driver link state propagation to ip stack
In-Reply-To: <41E8155D.3020802@pantasys.com>
Message-ID: <Pine.LNX.4.61.0501150512470.15839@sheen.jakma.org>
References: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee>
 <41E8155D.3020802@pantasys.com>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, Peter Buckingham wrote:

> I recently had similar problems (specifically with the e1000 
> driver). When one hang goes down a send to the other interface will 
> hang. This was when we were using the same socket to send on both 
> interfaces, what resulted is that the socket buffer would fill up 
> and cause the send to block. If you aren't using the same socket to 
> send out on both interfaces you should be fine. the rather large 
> hack that i used to get this to work on my system is below. 
> basically it will not enqueue a packet when the interface is down. 
> this may well do nasty things to tcp...

There's an old thread on netdev, occasionally resurrected, about this 
behaviour btw.

> peter

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
I hear what you're saying but I just don't care.
