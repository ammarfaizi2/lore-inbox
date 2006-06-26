Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWFZUwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWFZUwc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWFZUwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:52:32 -0400
Received: from r16s03p19.home.nbox.cz ([83.240.22.12]:39358 "EHLO
	scarab.smoula.net") by vger.kernel.org with ESMTP id S1751266AbWFZUwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:52:31 -0400
Subject: NFS and partitioned md
From: Martin Filip <bugtraq@smoula.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 26 Jun 2006 22:52:25 +0200
Message-Id: <1151355145.4460.16.camel@archon.smoula-in.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to LKML,

few days ago I've changed my sw RAID5 to use md_d devices, which are
"partitonable". (major 254, minor dependant on partiton no)

The problem is with kernel space NFS daemon. When I create loopback
device and export it - everything works OK, but when exported directory
is directly something goes really wrong and it's not possible to mount
it.

I'm getting "nfs: server 192.168.0.2 not responding, timed out" in my
kernel log, when I look on what's happening on network, the last thing
what's there are 3 retransmitted GETATTR calls without any response. 

I'm a little bit confused because I thought that NFS should work on
filesystem and should not care about devices, but it seems that it's not
true.

Is here someone who is interested in this problematic and know whether
this is bug or feature? I've done lots of googling, but had not found
anything relevant :(

Many thanks in advance...

-- 
Martin Filip
e-mail: nexus@smoula.net
ICQ#: 31531391
jabber: nexus@smoula.net

 ________________________________________ 
/ BOFH Excuse #274: It was OK before you \
\ touched it.                            /
 ---------------------------------------- 
       \   ,__,
        \  (oo)____
           (__)    )\
              ||--|| *

