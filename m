Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314417AbSEBNkH>; Thu, 2 May 2002 09:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSEBNkG>; Thu, 2 May 2002 09:40:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60123 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314417AbSEBNkF>;
	Thu, 2 May 2002 09:40:05 -0400
Date: Thu, 02 May 2002 06:28:47 -0700 (PDT)
Message-Id: <20020502.062847.124577895.davem@redhat.com>
To: Alexander.Riesen@synopsys.com
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.5.12(bk): IPv6 over IPv4 tunnel device initialization
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020502143335.A9241@riesen-pc.gr05.synopsys.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alex Riesen <Alexander.Riesen@synopsys.com>
   Date: Thu, 2 May 2002 14:33:35 +0200

   Hello,
   just came across a suspicious warning:
   
   ...
     CC net/ipv6/ip6_input.o
     CC net/ipv6/addrconf.o
     CC net/ipv6/sit.o
   .../net/ipv6/sit.c:67: warning: initialization makes integer from pointer without a cast
   ...
   
   It looks like the order of fields in net_device has changed,
   as the net_device::init is not initialized now with
   ipip6_fb_tunnel_init, but with a 0.
   Using field labels in the initialization would be a good thing, imho.
   

I've sent Linus a fix for this...
