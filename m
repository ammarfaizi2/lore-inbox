Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263082AbRE1QEh>; Mon, 28 May 2001 12:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263083AbRE1QE1>; Mon, 28 May 2001 12:04:27 -0400
Received: from mx-02.carambole.com ([213.180.68.10]:36622 "HELO
	mx-02.carambole.com") by vger.kernel.org with SMTP
	id <S263082AbRE1QEP>; Mon, 28 May 2001 12:04:15 -0400
Message-ID: <3B12769F.CAC4ED8F@opensource.se>
Date: Mon, 28 May 2001 18:02:39 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: incorrect help for NETLINK in 2.2.19
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I think I've found some incorrect helptexts in 2.2.19:

I've compared the netlink config options for 2.2.19 with 2.4.5.

1. CONFIG_NETLINK - Enabling netlink

   The help in 2.4.5 seems correct to me.
   2.2.19 raves about nodes under /dev with major 36.  (BAD)


2. CONFIG_RTNETLINK - Route messages over netlink.

   2.4.5 seems good here too.
   2.2.19 tells us to create a /dev/route node.        (BAD)


3. CONFIG_NETLINK_DEV - Enable support for major 36 nodes.

   2.4.5 says that this option enables major 36 nodes.
   2.2.19 says nothing useful at all.                  (BAD)


CONFIG_NETLINK_DEV enables major 36 char devices for both 2.2 
and 2.4, right? 

If that is true then I suggest that the 2.4.5-help for NETLINK
is used for next 2.2-kernel.

And - the help for CONFIG_RTNETLINK claims that data sent to the
kernel is ignored. Is that really true?

Tell me if you want a patch.

Thanks /

Magnus Damm


http://opensource.se - open source in sweden
