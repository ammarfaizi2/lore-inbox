Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318734AbSICHlW>; Tue, 3 Sep 2002 03:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318730AbSICHlW>; Tue, 3 Sep 2002 03:41:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19410 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318725AbSICHlV>;
	Tue, 3 Sep 2002 03:41:21 -0400
Date: Tue, 03 Sep 2002 00:39:13 -0700 (PDT)
Message-Id: <20020903.003913.105174967.davem@redhat.com>
To: jros@ece.uci.edu
Cc: scott.feldman@intel.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, haveblue@us.ibm.com, Manand@us.ibm.com,
       kuznet@ms2.inr.ac.ru, christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <JCEFIMMPGNNGFPMJJKINIEMJCDAA.jros@ece.uci.edu>
References: <20020902.235244.64832172.davem@redhat.com>
	<JCEFIMMPGNNGFPMJJKINIEMJCDAA.jros@ece.uci.edu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Jordi Ros" <jros@ece.uci.edu>
   Date: Tue, 3 Sep 2002 00:26:13 -0700

   What i am wondering is how come we only get a few percentage
   improvement in throughput

Because he's maxing out the physical medium already.

All the headers for each 1500 byte packet still have to hit the
physical wire, that isn't what is being eliminated.  It's just
what is going over the PCI bus to the card that is being made
smaller.
