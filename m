Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbTJWXN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTJWXN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:13:29 -0400
Received: from portraits-china.wsisiz.edu.pl ([213.135.44.169]:3146 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S261856AbTJWXN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:13:27 -0400
Date: Fri, 24 Oct 2003 01:09:14 +0200
Message-Id: <200310232309.h9NN9E1A002324@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@trabinski.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre8
In-Reply-To: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: 5C87 7FF4 9539 6AA9 4EEF  529D 0236 ECCB 70F1 E978
X-Key-ID: 70F1E978
User-Agent: tin/1.6.2-20030910 ("Pabbay") (UNIX) (Linux/2.4.23-pre8 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet> you wrote:
> Chas Williams:
>  o [ATM]: rewrite recvmsg to use skb_copy_datagram_iovec
>  o [ATM]: remove listenq and backlog_quota from struct atm_vcc
>  o [ATM]: cleanup connect
>  o [ATM]: eliminate SOCKOPS_WRAPPED
>  o [ATM]: move vcc's to global sk-based linked list
>  o [ATM]: setsockopt/getsockopt cleanup

Well, ATM dosen't work for me. (from 2.4.22, 2.4.21 is OK).

No traffic via ATM interfeces.

[root@voices root]# ifconfig atm1
atm1      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          inet addr:XXX.XX.XX.XXX  Mask:255.255.255.252
          UP RUNNING  MTU:9180  Metric:1
          RX packets:9 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:632 (632.0 b)  TX bytes:100 (100.0 b)

Counters on all atm interfeces are still the same

On good working kernel, during boot, i have messages like this:

atm_connect (TX: cl 1,bw 0-0,sdu 9188; RX: cl 1,bw 0-0,sdu 9188,AAL 5)
atm_connect (TX: cl 1,bw 0-0,sdu 9188; RX: cl 1,bw 0-0,sdu 9188,AAL 5)
atm_connect (TX: cl 1,bw 0-0,sdu 9188; RX: cl 1,bw 0-0,sdu 9188,AAL 5)
atm_connect (TX: cl 1,bw 0-0,sdu 9188; RX: cl 1,bw 0-0,sdu 9188,AAL 5)
atm_connect (TX: cl 1,bw 0-0,sdu 9188; RX: cl 1,bw 0-0,sdu 9188,AAL 5)

from 2.4.22 I haven't any messages like above, only:

nicstar0: PHY seems to be 155 Mbps.
nicstar0: MAC address 00:20:48:0E:B3:28

What's going on? I don't want test 2.6.* kernels on my routers.

-- 
*[ £ukasz Tr±biñski ]*
