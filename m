Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266710AbUAWW3f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 17:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266699AbUAWW31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 17:29:27 -0500
Received: from fmr06.intel.com ([134.134.136.7]:15543 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266710AbUAWW2p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 17:28:45 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [2.6.x] e1000: NETDEV WATCHDOG: eth0: transmit timed out
Date: Fri, 23 Jan 2004 14:28:36 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102229D92@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.x] e1000: NETDEV WATCHDOG: eth0: transmit timed out
Thread-Index: AcPh+p0ZLtJ0cujJSy2EzaaQtXQVKgABWmUA
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Petr Sebor" <petr@scssoft.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Jan 2004 22:28:37.0469 (UTC) FILETIME=[3E9A68D0:01C3E200]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> since we have upgraded cabling on our network and transfer 
> speeds increased a little bit, we are experiencing very often 
> situations where the Intel PRO/1000 nics just stop responding 
> and network dies for a while. Local console works, there are 
> no more error messages other than (when the eth0 comes to a 
> life again):
> 
> NETDEV WATCHDOG: eth0: transmit timed out
> e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex

Petr, I need you to try something.  Get ethtool 1.8
(sf.net/projects/gkernel) and turn off TSO:

  # ethtool -K eth0 tso off

If you now longer see NETDEV WATCHDOG's, I have a next step.  More on
that later.

-scott
