Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbREXW2z>; Thu, 24 May 2001 18:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262439AbREXW2p>; Thu, 24 May 2001 18:28:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42632 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262436AbREXW2f>;
	Thu, 24 May 2001 18:28:35 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15117.35598.604699.7292@pizda.ninka.net>
Date: Thu, 24 May 2001 15:28:30 -0700 (PDT)
To: Bharath Madhavan <bharath_madhavan@ivivity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accelerated TCP/IP support from kernel
In-Reply-To: <25369470B6F0D41194820002B328BDD207179D@ATLOPS>
In-Reply-To: <25369470B6F0D41194820002B328BDD207179D@ATLOPS>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bharath Madhavan writes:
 > 	I am looking into a scenario where we have a NIC which performs 
 > all the TCP/IP processing and basically the core CPU offloads all data from
 > the socket level interface onwards to this NIC. 

Why would you ever want to do this?

Point 1: Support for new TCP techniques and bug fixes are hard enough
to propagate to user's systems as it is with the implementation being
done in software.

Point 2: If I find a bug in the cards TCP implementation, will I be
able to get at the source for the firmware and fix it?  Likely the
answer to this is no.

Every couple years a few vendors make cards like this, yet ignore
these core issues.  It is currently impractical to use these kinds of
cards today except in a few very special case situations.

Furthermore, the actual protocol processing overhead is quite small
and almost neglible especially on today's gigahertz beasts.  The data
copy is where the time is spent, and checksum offload takes care of
that.

Later,
David S. Miller
davem@redhat.com
