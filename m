Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbVLESw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbVLESw3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVLESw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:52:29 -0500
Received: from mail.dvmed.net ([216.237.124.58]:33932 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751406AbVLESw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:52:28 -0500
Message-ID: <43948C65.4060405@pobox.com>
Date: Mon, 05 Dec 2005 13:52:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>, Jouni Malinen <jkmaline@cc.hut.fi>
CC: bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Feyd <feyd@seznam.cz>
Subject: Re: [Bcm43xx-dev] Broadcom 43xx first results
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <200512051208.16241.mbuesch@freenet.de> <20051205141935.GC8940@jm.kir.nu> <200512051528.33146.mbuesch@freenet.de>
In-Reply-To: <200512051528.33146.mbuesch@freenet.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  In general, Jouni's points are good, as are Michael's.
	The key question is about the size of the SoftMAC code. If its huge, an
	ieee80211 sub-module makes sense. If it's not, then adding the code to
	net/ieee80211 makes a lot more sense. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In general, Jouni's points are good, as are Michael's.

The key question is about the size of the SoftMAC code.  If its huge, an 
ieee80211 sub-module makes sense.  If it's not, then adding the code to 
net/ieee80211 makes a lot more sense.

Certainly some chips will use more ieee80211 code than others.  This is 
no different than ethernet NICs:  some make use of TSO and checksum 
offload code included in every kernel, while for other NICs the kernel 
TSO/csum code is just dead weight.

In general, adding directly to net/ieee80211 is preferred, UNLESS there 
are overriding reasons not to do so (such as a huge size increase).

	Jeff



