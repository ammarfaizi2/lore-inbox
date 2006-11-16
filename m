Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162134AbWKPBFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162134AbWKPBFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 20:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162140AbWKPBFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 20:05:18 -0500
Received: from hierophant.serpentine.com ([64.81.58.173]:24721 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1162134AbWKPBFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 20:05:16 -0500
Message-ID: <455BB95E.8090600@serpentine.com>
Date: Wed, 15 Nov 2006 17:05:34 -0800
From: "Bryan O'Sullivan" <bos@serpentine.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: William D Waddington <william.waddington@beezmo.com>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFCLUE3] flagging kernel interface changes
References: <455B9133.9030704@beezmo.com> <1163629533.31358.168.camel@laptopd505.fenrus.org> <455B96C7.8010202@beezmo.com>
In-Reply-To: <455B96C7.8010202@beezmo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William D Waddington wrote:

> The other part of the question is why this irq_handler prototype change
> in 2.6.19 isn't flagged to make things a little easier.

For in-tree drivers, it broke the compilation of any drivers that relied 
upon it, and they were then fixed, and most of the fixing occurred 
before the changes made it into any widely used tree.  That 
break-it-and-fix-it approach is typically seen as flagging enough.  If 
your driver isn't in-tree, it's invisible to kernel maintainers.

For out-of-tree drivers, your best bet is to follow Jonathan Corbet's 
notes on LWN.  He's pretty good about describing impending widespread 
breakage before it hits the main tree.

	<b
