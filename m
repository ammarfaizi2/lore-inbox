Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTFPNtG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 09:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTFPNtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 09:49:06 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.9]:47269 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262063AbTFPNtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 09:49:03 -0400
Date: Mon, 16 Jun 2003 10:02:41 -0400
From: Jeff <jeffpc@optonline.net>
Subject: Re: 64-bit fields in struct net_device_stats
In-reply-to: <5.1.0.14.2.20030616154156.0253dc98@mira-sjcm-3.cisco.com>
To: Lincoln Dale <ltd@cisco.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Message-id: <200306161002.50506.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <200306152253.36768.jeffpc@optonline.net>
 <5.1.0.14.2.20030616154156.0253dc98@mira-sjcm-3.cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 16 June 2003 01:47, Lincoln Dale wrote:
> why not a set of counters which are toggled between.
>
> e.g.
>          struct netdevice... {
>            uint64        tx_pkts_counter[2];
>            uint64 tx_octets_counter[2];
>            uint64        rx_pkts_counter[2];
>            uint64 rx_octets_counter[2];
>            int counter_bounce;
>          ...
>          }
<snip>

Hmm, interesting idea. The one thing is: There are 23 fields in struct 
net_device_stats right now; if each of them is 64bits (=8 bytes), the whole 
structure would be 184 bytes (with u_int64.) Now if I have two of each, the 
size would grow to 368 bytes (plus the 4 bytes for counter_bounce). Now, the 
question: would it be acceptable to have something that size?

Jeff.

- -- 
*NOTE: This message is ROT-13 encrypted twice for extra protection*
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7c4FwFP0+seVj/4RAtGxAJsE+YY48y1mp+Y90FFH2Jz+hmU+fgCeK+gj
6ksJ8KxDYVo7rwxODwSAeT8=
=Sxo5
-----END PGP SIGNATURE-----

