Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292805AbSBVGBr>; Fri, 22 Feb 2002 01:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292804AbSBVGBi>; Fri, 22 Feb 2002 01:01:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6272 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292803AbSBVGBT>;
	Fri, 22 Feb 2002 01:01:19 -0500
Date: Thu, 21 Feb 2002 21:59:25 -0800 (PST)
Message-Id: <20020221.215925.41634293.davem@redhat.com>
To: dank@kegel.com
Cc: linux-kernel@vger.kernel.org, zab@zabbo.net
Subject: Re: is CONFIG_PACKET_MMAP always a win?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C75A418.2C848B3F@kegel.com>
In-Reply-To: <3C75A418.2C848B3F@kegel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dan Kegel <dank@kegel.com>
   Date: Thu, 21 Feb 2002 17:51:20 -0800

   What's the best way to retrieve raw packets from the kernel?
   
   a) use libpcap
 ...   
   b) use af_packet
 ...   
   c) enable CONFIG_PACKET_MMAP, use PACKET_RX_RING
   
   If I understand it right, b costs one memcpy and one recv, and c costs
   two memcpys.  Which one wins?

"a" should be doing "c" when it is available in the kernel.
If not, get a newer copy of the libpcap sources, preferably
from Alexey's site:

ftp.inr.ac.ru:/ip-routing/
