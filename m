Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267371AbRGPN0C>; Mon, 16 Jul 2001 09:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267373AbRGPNZx>; Mon, 16 Jul 2001 09:25:53 -0400
Received: from mgw-x2.nokia.com ([131.228.20.22]:57301 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S267371AbRGPNZm>;
	Mon, 16 Jul 2001 09:25:42 -0400
Date: Mon, 16 Jul 2001 16:22:17 +0300
To: linux-kernel@vger.kernel.org
Subject: Is ip_build_xmit_slow() unused?
Message-ID: <20010716162217.A12873@terrapin>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: alexey.vyskubov@nokia.com (Alexey Vyskubov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have probably stupid question: what is the purpose of
ip_build_xmit_slow()?

Grepping over linux kernel source tree finds only two entries for
ip_build_xmit_slow():

net/ipv4/ip_output.c:static int ip_build_xmit_slow(struct sock *sk,

net/ipv4/ip_output.c:                   return
ip_build_xmit_slow(sk,getfrag,frag,length,ipc,rt,flags); 

Please notice that the second entry is inside ip_build_xmit_slow()
definition, i.e. this is recursive call.

Is this function really unused?

-- 
Alexey
