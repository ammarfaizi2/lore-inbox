Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUAXUIh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 15:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266996AbUAXUIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 15:08:36 -0500
Received: from s4.uklinux.net ([80.84.72.14]:12450 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S263082AbUAXUIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 15:08:34 -0500
From: "Nick" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 24 Jan 2004 20:08:01 -0000
MIME-Version: 1.0
Subject: 2.4.25-pre7 ip_conntrack warning
Reply-To: nick@ukfsn.org
Message-ID: <4012D0A1.4537.6C01A7A0@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

My first post :)

I noticed a problem with building this - I have netfilter built in 
the kernel, and get a warning from GCC in:

net/ivp4/netfilter/ip_conntrack_core.c 

in 

'ip_conntrack_helper_unregister' at line 1160:

passing arg 1 at 'unhelp' discards qualifier from pointer target 
type.

        for (i = 0; i < ip_conntrack_htable_size; i++)
--->             LIST_FIND_W(&ip_conntrack_hash[i], unhelp,
                            struct ip_conntrack_tuple_hash *, me);

It appears not to cause any problems...

Sorry if I reported this wrongly, or wayward - still learning :)

Nick
