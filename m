Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTFPSoA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbTFPSnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:43:42 -0400
Received: from fmr01.intel.com ([192.55.52.18]:30708 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264178AbTFPSmP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:42:15 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: e1000 performance hack for ppc64 (Power4)
Date: Mon, 16 Jun 2003 11:56:03 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010107D94F@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e1000 performance hack for ppc64 (Power4)
Thread-Index: AcM0NZhCXHVlgXspR9CtCHUR7FqVhgAAfjpQ
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Cc: "Herman Dierks" <hdierks@us.ibm.com>, "David S. Miller" <davem@redhat.com>,
       <ltd@cisco.com>, "Anton Blanchard" <anton@samba.org>, <dwg@au1.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Nancy J Milliner" <milliner@us.ibm.com>,
       "Ricardo C Gonzalez" <ricardoz@us.ibm.com>,
       "Brian Twichell" <twichell@us.ibm.com>, <netdev@oss.sgi.com>
X-OriginalArrivalTime: 16 Jun 2003 18:56:03.0535 (UTC) FILETIME=[EF5FC5F0:01C33438]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Scott, would you be pleased if something was implemented out 
> of the driver, in generic net code?  Something that all the 
> drivers could use, even if nothing but e1000 used it for now.

I suppose the driver could unconditionally call something like
skb_realign_for_broken_hw, which is a nop on non-broken archs, but would
it make more sense to not have the driver mess with the skb at all?

-scott
