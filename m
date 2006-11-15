Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030553AbWKOPV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbWKOPV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbWKOPV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:21:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:58511 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030553AbWKOPV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:21:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mMm2z81b65nAWhA8ys9srzorpmG6JbCIEi3Q0OHvdWuWLK2a5MKsfcox+7+lo92WO9whywAe5iMR4uPSBU8+Z3hWS1HwjCCstKTjMDbzVwlVq/WUZ4Naike/GQ7HbtWbspy/JZCZpksbqyTWqG1HxbdEp5l8mrR1TPMbvmbStAQ=
Message-ID: <a01763360611150721l4281b2e1j55b26469d79f9c76@mail.gmail.com>
Date: Wed, 15 Nov 2006 16:21:54 +0100
From: "Carlo Bellettini" <cbellettini@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: netlink messages on ARP events
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm experimenting with NETLINK_ROUTE socket on 2.6.16 (patched with
mipl - mobile ipv6 for linux), in order to monitor the state of the
arp table.
On kernel 2.6.8, when an entry was - even manually - added or deleted,
a RTM_NEWNEIGH message was sent to the multicast group RTMGRP_NEIGH,
which I'm listening to. On 2.6.16, no such message is sent, except for
IPv6 events.
I compiled 2.6.16 with CONFIG_ARPD and set
"/proc/sys/net/ipv4/neigh/*/app_solicit" to a value > 0, but no luck.
I know there exists NETLINK_ARPD, but it should be used to manage, not
monitor, the arp table (it doesn't support multicast, anyway), if I'm
not wrong. Any suggestion is welcome.

Please CC me, since I did not subscribed the mailing list.

Thank you,

Carlo Bellettini
