Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbTFUMeP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 08:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbTFUMeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 08:34:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21959
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265179AbTFUMeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 08:34:11 -0400
Subject: Re: [PATCH] 2.[45] eexpress.c skb_padto fixes broke pppoe
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Shane Shrybman <shrybman@sympatico.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1055975326.28012.13.camel@mars.goatskin.org>
References: <1055975326.28012.13.camel@mars.goatskin.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056199563.25974.29.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jun 2003 13:46:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-18 at 23:28, Shane Shrybman wrote:
> Hi,
> 
> I posted this to linux-net and didn't get a reply so I am posting it
> here. Please cc any replies.

Cleaner is to set buf->len = ETH_ZLEN for the padto path IMHO, that
keeps the old horrible length compute stuff dead

