Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265339AbUFXUBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUFXUBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 16:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUFXUBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 16:01:36 -0400
Received: from [141.211.133.132] ([141.211.133.132]:37251 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265339AbUFXUBc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 16:01:32 -0400
Subject: Re: NFS lockups+empty directories
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jaco Kroon <jkroon@cs.up.ac.za>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40DAA4AA.5000102@cs.up.ac.za>
References: <40DAA4AA.5000102@cs.up.ac.za>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1088107270.5194.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Jun 2004 16:01:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 24/06/2004 klokka 05:53, skreiv Jaco Kroon:
> Hello there
> 
> I'm having 2 problems with nfs atm, I'll first describe the problem of 
> the mysterious deadlocks.
> 
> On the client that has deadlocked I see these (tcpdump host servername -n)
> 11:37:31.272353 IP 137.215.40.16.3750658894 > 137.215.98.25.2049: 140 
> read [|nfs]
> 11:37:32.671933 IP 137.215.40.16.3717104462 > 137.215.98.25.2049: 140 
> read [|nfs]
> 11:37:33.371732 IP 137.215.40.16.3733881678 > 137.215.98.25.2049: 140 
> read [|nfs]
> 
> On the server I get lots and lots of these (tcpdump host clientname -n)
> 11:39:23.239369 IP 137.215.40.16.3733881678 > 137.215.98.25.2049: 140 
> read [|nfs]
> 11:37:03.280950 IP 137.215.98.25.2049 > 137.215.40.16.3717104462: reply 
> ok 1472 read [|nfs]
> 11:37:03.280965 IP 137.215.98.25 > 137.215.40.16: udp
> 11:37:03.280975 IP 137.215.98.25 > 137.215.40.16: udp
> 11:37:03.280986 IP 137.215.98.25 > 137.215.40.16: udp
> 11:37:03.280997 IP 137.215.98.25 > 137.215.40.16: udp
> 11:37:03.281008 IP 137.215.98.25 > 137.215.40.16: udp
> 
> The port numbers are *obviously* wrong, but I suspect this is a tcpdump 
> problem.  What worries me is that it doesn't look like the packets from 
> the server reaches the client.

You are using UDP: There are never any guarantees there that the packets
from the server will actually reach the client. Now please read the
sections in the NFS FAQ and HOWTOs about this sort of problem:

  http://nfs.sourceforge.net/

Cheers,
  Trond
