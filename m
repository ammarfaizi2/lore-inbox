Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269740AbRHIJAQ>; Thu, 9 Aug 2001 05:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269744AbRHIJAG>; Thu, 9 Aug 2001 05:00:06 -0400
Received: from host217-33-139-17.ietf.ignite.net ([217.33.139.17]:59015 "HELO
	bee5.dirksteinberg.de") by vger.kernel.org with SMTP
	id <S269740AbRHII7v> convert rfc822-to-8bit; Thu, 9 Aug 2001 04:59:51 -0400
Message-ID: <3B724F1E.F354795E@dirksteinberg.de>
Date: Thu, 09 Aug 2001 09:51:42 +0100
From: "Dirk W. Steinberg" <dws@dirksteinberg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-mosix106 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Swapping for diskless nodes
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

what is the best/recommended way to do remote swapping via the network
for diskless workstations or compute nodes in clusters in Linux 2.4? 
Last time i checked was linux 2.2, and there were some races related 
to network swapping back then. Has this been fixed for 2.4?

What about the following options: Do they work at all? What are the advantages/
disadvantages? What are the performance implications? Race conditions?

1. Swapping via NFS? There was a patch for this for 2.2? Is there such a
   patch for 2.4 as well? Should one use UDP or TCP? NFSv2? NFSv3?

2. Using some sort of network block device (nbd, new nbd, gnbd, drbd, 
   possibly others?). Which one to use? I suspect that for performance
   a kernel mode implementation is needed for both client and server.

3. iSCSI. There are several implementations, and I don't know if any of 
   these is ready for production use. Both initiator and target 
   implementation would be needed because I don't have any native iSCSI
   targets available.

4. Swapping to GFS? Is that possible? Even if GFS is based on gnbd, not FC?

5. Anything else? Maybe some implementation of network memory in the context
   of a cluster computing environment (MOSIX, etc.).

Thanks for any answers.

Cheers,
	Dirk

------------------------------------------
Ingenieurbüro Dipl.-Ing. Dirk W. Steinberg
Ringstr. 2, D-53567 Buchholz, Germany
Phone: +49-2683-9793-20, fax: -29
Mobile/GSM: +49-170-818-9793
Email: dws@dirksteinberg.de
