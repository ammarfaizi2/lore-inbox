Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276914AbRJVPyL>; Mon, 22 Oct 2001 11:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276532AbRJVPyB>; Mon, 22 Oct 2001 11:54:01 -0400
Received: from ns1.jasper.com ([64.19.21.34]:9868 "EHLO ersfirep1")
	by vger.kernel.org with ESMTP id <S276914AbRJVPxt>;
	Mon, 22 Oct 2001 11:53:49 -0400
From: "Radivoje Todorovic" <radivojet@jaspur.com>
To: <linux-kernel@vger.kernel.org>
Subject: NETFILTER Hook Hack: Interesting Issue
Date: Mon, 22 Oct 2001 10:52:00 -0500
Message-ID: <BOEOJGNGENIJJMAOLHHCCEPICDAA.radivojet@jaspur.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.33.0110221720260.10673-100000@server>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


Assume "int bla(struct sk_buff *skb)" is called from one of the five
netfilter hooks. And say,once you have the packet in your callback, you want
to create some dummy packet and send it along with original skb. How would
you do this?

Actually one solution would be to export symbol "ip_finish_output2" and then
use it for extra packet in the module. Then the return NF_ACCEPT would send
original skb out.

But how to do this without patching the kernel???


Rade

