Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbVH1XQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVH1XQw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 19:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVH1XQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 19:16:52 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:36366 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750925AbVH1XQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 19:16:51 -0400
Message-ID: <431245E2.5010308@superbug.demon.co.uk>
Date: Mon, 29 Aug 2005 00:16:50 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Wezel <dio@qwasartech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB EHCI Problem with Low Speed Devices on kernel 2.6.11+
References: <43106DEF.3040206@qwasartech.com>
In-Reply-To: <43106DEF.3040206@qwasartech.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Wezel wrote:
> Problem
> =======
> When turning on the laptop and during POST and GrUB loading, all ports 
> on the hub are enabled.  During the USB initialization phase, when the 
> hub is detected, shortly all ports become disabled, then turn on again 
> (uhci_hcd detects the lo-speed ports).  Upon initialization of ehci_hcd 
> however, the ports are disconnected again (for good):
> 

Use uhci_hcd or ehci_hcd, but never both at the same time.
ehci_hcd will work with all lo-speed ports, so uhci_hcd is then no needed.

James

