Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265583AbTFMXmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 19:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbTFMXmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 19:42:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49338 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265583AbTFMXmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 19:42:54 -0400
Date: Fri, 13 Jun 2003 16:52:50 -0700 (PDT)
Message-Id: <20030613.165250.41635765.davem@redhat.com>
To: scott.feldman@intel.com
Cc: anton@samba.org, haveblue@us.ibm.com, hdierks@us.ibm.com, dwg@au1.ibm.com,
       linux-kernel@vger.kernel.org, milliner@us.ibm.com, ricardoz@us.ibm.com,
       twichell@us.ibm.com, netdev@oss.sgi.com
Subject: Re: e1000 performance hack for ppc64 (Power4)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E010107D93A@orsmsx402.jf.intel.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E010107D93A@orsmsx402.jf.intel.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Feldman, Scott" <scott.feldman@intel.com>
   Date: Fri, 13 Jun 2003 16:52:18 -0700

   > > Why not instead find out if it's possible to have the e1000 
   > > fetch the entire cache line where the first byte of the
   > > packet resides?  Even ancient designes like SunHME do that.
   > 
   > Rusty and I were wondering why the e1000 didnt do that exact thing.
   > 
   > Scott: is it possible to enable such a thing?
   
   I thought the answer was no, so I double checked with a couple of
   hardware guys, and the answer is still no.

Sigh...

So Anton, when the PCI controller gets a set of sub-cacheline word
reads from the device, it reads the value from memory once for every
one of those words?  ROFL, if so...  I can't believe they wouldn't
put caches on the PCI controller for this, at least a one-behind that
snoops the bus :(
