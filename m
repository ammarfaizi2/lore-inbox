Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWIMOqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWIMOqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWIMOqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:46:55 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:42197 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750808AbWIMOqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:46:54 -0400
Date: Wed, 13 Sep 2006 16:46:37 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Peter Lezoch <pledr@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Error binding socket: address already in use
In-Reply-To: <1GNVuW-02KMfw0@fwd29.sul.t-online.de>
Message-ID: <Pine.LNX.4.61.0609131645560.20792@yvahk01.tjqt.qr>
References: <1GNVuW-02KMfw0@fwd29.sul.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Hi,
>killing a server task that is operating on a UDP socket( AF_INET, 
>SOCK_DGRAM, IPPROTO_UDP ), leaves the socket in an unclosed state. A 
>subsequently started task, that wants to use the same port, gets from 
>bind above error message.This is, in my opinion, wrong behavior, 

man setsockopt
Look for SO_REUSEADDR
It is all correct behavior.

>because of the connectionless nature of UDP. Only reboot solves this 

Waiting a while should also solve this.

>situation. It looks, as if in net/socket.c, TCP and UDP are handled in 
>the same way without taking into account the different nature of the 
>protocols?!
>How can I overcome this problem ?

Jan Engelhardt
-- 
