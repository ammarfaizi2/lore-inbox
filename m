Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTLDRhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 12:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTLDRhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 12:37:39 -0500
Received: from fmr06.intel.com ([134.134.136.7]:64196 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262033AbTLDRhh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 12:37:37 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Extremely slow network with e1000 & ip_conntrack
Date: Thu, 4 Dec 2003 09:37:19 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD21@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Extremely slow network with e1000 & ip_conntrack
Thread-Index: AcO6YzCMZ+cXbiKzShKV2I+NDTwrjwAKe2EA
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Stephen Lee" <mukansai@emailplus.org>
Cc: "Harald Welte" <laforge@netfilter.org>,
       <netfilter-devel@lists.netfilter.org>, <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
X-OriginalArrivalTime: 04 Dec 2003 17:37:20.0480 (UTC) FILETIME=[44DA0600:01C3BA8D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it not supported by the hardware?  Seems TSO could improve 
> performance a bit since the 1000/MT Desktop is starved for 
> PCI bandwidth at 32-bit/33MHz.

TSO is support on 82540.  Turning off TSO is a workaround, but what's
behind the dependency of TSO and ip_conntrack?  You indicated in an
earlier note that having the ip_conntrack module loaded was a factor.
Do you have a nic to try with tg3?  I believe tg3 has TSO enabled as
well (in 2.6.0-test11).

-scott
