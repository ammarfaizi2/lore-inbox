Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136373AbREIMmd>; Wed, 9 May 2001 08:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136374AbREIMmX>; Wed, 9 May 2001 08:42:23 -0400
Received: from warszawa.7bulls.com ([213.134.131.62]:56082 "HELO
	warszawa.7bulls.com") by vger.kernel.org with SMTP
	id <S136373AbREIMmQ>; Wed, 9 May 2001 08:42:16 -0400
Date: Wed, 9 May 2001 14:29:06 +0000
To: linux-kernel@vger.kernel.org
Subject: dev_add_pack() question
Message-ID: <20010509142906.B1388@lda.sur5.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: nergal@7bulls.com (Rafal Wojtczuk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I register a callback function with dev_add_pack() this way:
  memset (&proto, 0, sizeof proto);
  proto.type = htons (ETH_P_ALL);
  proto.func = my_callback_function;
  dev_add_pack (&proto);
my_callback_function() receives all packets with local src/dst IP (including
SNATed ones) as well as all incoming ones, but forwarded outgoing packets are 
not passed to my_callback_function(). Looks like AF_PACKET sockets also rely 
on dev_add_pack(), yet of course tcpdump (correctly) shows all the packets. 
How should I register a callback with dev_add_pack() so that the callback
receives all the packets ?

Save yourself,
Nergal

