Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUIGP0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUIGP0l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268353AbUIGPWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:22:55 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:31492 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S268209AbUIGPTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:19:46 -0400
Message-ID: <413DD17E.3050804@protactive.nl>
Date: Tue, 07 Sep 2004 17:19:26 +0200
From: Ludo Stellingwerff <ludo@protactive.nl>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sporadic hitting the BUG() in the XFRM Garbage Collector
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One of our client's machines sometimes hits the BUG() in xfrm_state.c 
(line 54).
This seems to happen at the removal of a IPsec policy. Some data: kernel 
2.6.6. with Netfilter POM IPSEC-patches, ipsec-tools 0.2.3.

If I read the code correctly this would mean that the garbage collector 
tries to stop an earlier deactivated timer. (del_timer returning '0')

Does anybody know what causes this? And, is a kernel BUG not a bit too 
drastic for this error condition?  Wouln't a WARN_ON suffice?

Thanks in advance,
Greetings,
Ludo Stellingwerff.

PS. As I'm currently not subscribed please CC me directly.

-- 
Ludo Stellingwerff

V&S B.V. The Netherlands
ProTactive firewall solution.
Tel: +31 172 416116
Fax: +31 172 416124

site: www.protactive.nl
demo: http://www.protactive.nl:81/netview.html


