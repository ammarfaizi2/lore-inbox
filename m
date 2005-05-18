Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVERSV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVERSV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVERSV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:21:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:65226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262297AbVERSUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:20:47 -0400
Message-ID: <428B876F.8080802@osdl.org>
Date: Wed, 18 May 2005 11:20:31 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Filipe Abrantes <fla@inescporto.pt>
CC: linux-kernel@vger.kernel.org
Subject: Re: Detecting link up
References: <428B1A60.6030505@inescporto.pt>
In-Reply-To: <428B1A60.6030505@inescporto.pt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Filipe Abrantes wrote:
> Hi all,
> 
> I need to detect when an interface (wired ethernet) has link up/down. Is 
> there a system signal which is sent when this happens? What is the best 
> way to this programatically?
> 
> Best Regards
> 
> Filipe
> 
> 

The best way is to open a netlink socket and look for the mesaages about
link up/down there. Read iproute2 http://developer.osdl.org/dev/iproute2 
source for ip command (ipmonitor.c).

This works for almost all devices unlike ethtool and mii which only
work on a small subset of devices.
