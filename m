Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWBPVLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWBPVLX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWBPVLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:11:23 -0500
Received: from main.gmane.org ([80.91.229.2]:42468 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964794AbWBPVLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:11:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan-Frode Myklebust <mykleb@no.ibm.com>
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
Date: Thu, 16 Feb 2006 22:02:48 +0100
Message-ID: <slrndv9q3o.pib.mykleb@99RXZYP.ibm.com>
References: <e282236e0602070146p1ed3fdb6k74aa75e15bbc37a3@mail.gmail.com> <4807377b0602081207s7604eceahb8bf4af6715a6534@mail.gmail.com> <43EB9548.9060504@kernelpanic.ru> <cbec11ac0602091125w5a5a7c6em8462131e9f9b24dc@mail.gmail.com> <43EB98B0.4@kernelpanic.ru>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 62.80-202-42.nextgentel.com
User-Agent: slrn/0.9.8.1pl1 (Linux)
Cc: netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-02-09, Boris B. Zhmurov <bb@kernelpanic.ru> wrote:
>
>> Is it possible for you to download 2.6.16-rc2 or similar and see if it
>> goes away?
>
> It'll be better, if I get only patch fixs that problem, not all 2.6.16-rc2.

I just got this same warning on a system running 2.6.14.5. It's been
up for 50 days, quite heavily loaded, and I've seen this only once. 
Should i be conserned ? Could someone tell me what it means ?

# uname -a
Linux mail 2.6.14.5 #1 SMP Tue Dec 27 14:39:55 CET 2005 i686 i686 i386 GNU/Linux
# dmesg|grep KERNEL
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (148)
# ethtool -k eth0
Offload parameters for eth0:
rx-checksumming: on
tx-checksumming: on
scatter-gather: on
tcp segmentation offload: on
# ethtool -k eth1
Offload parameters for eth1:
rx-checksumming: on
tx-checksumming: on
scatter-gather: on
tcp segmentation offload: on


  -jf

