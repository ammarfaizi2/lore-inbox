Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286395AbSAUNjk>; Mon, 21 Jan 2002 08:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286411AbSAUNjU>; Mon, 21 Jan 2002 08:39:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:57516 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286395AbSAUNjS>;
	Mon, 21 Jan 2002 08:39:18 -0500
Date: Mon, 21 Jan 2002 05:37:24 -0800 (PST)
Message-Id: <20020121.053724.124970557.davem@redhat.com>
To: reid.hekman@ndsu.nodak.edu
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1011610422.13864.24.camel@zeus>
In-Reply-To: <1011610422.13864.24.camel@zeus>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
   Date: 21 Jan 2002 04:53:39 -0600
   
   As I have a couple systems that may/may not be affected, I'm seeking
   some clarification. Is this an effect of the errata published by AMD in
   the Athlon models 4 & 6 revision guides as "INVLPG Instruction Does Not
   Flush Entire Four-Megabyte Page Properly with Certain Linear Addresses"?
   That errata lists all Athlon Thunderbirds as affected and all Athlon
   Palominos except for stepping A5. 
   
   Regardless of specific errata listings, will future workarounds be
   enabled based on cpuid or via a test for the bug itself?

The funny part is, if this published errata is the problem, it cannot
be a problem under Linux since we never invalidate 4MB pages.  We
create them at boot time and they never change after that.
