Return-Path: <linux-kernel-owner+w=401wt.eu-S1753646AbWL1Qnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbWL1Qnf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 11:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbWL1Qnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 11:43:35 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:39286 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753645AbWL1Qnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 11:43:35 -0500
Date: Thu, 28 Dec 2006 17:42:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Netfilter Developer Mailing List 
	<netfilter-devel@lists.netfilter.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kaber@trash.net
Subject: skb->h not initialized
Message-ID: <Pine.LNX.4.61.0612281733550.23545@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


while writing a netfilter match module I found that, when run,
skb->h.th is not set to the TCP header (it is assured that the packet 
_is_ TCP), as this printk shows me:

skb: h.th=cb5bc4dc nh.iph=cb5bc4dc mac.raw=cb5bc4ce head=cb5bc400 
data=cb5bc4dc tail=cb5bc510 end=cb5bc580

Is it intended that skb->h.th is not set to skb->data + length of ip 
header (skb->data+protoff as far as netfilter matches are concerned)?


	-`J'
-- 
