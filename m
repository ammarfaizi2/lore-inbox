Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTDGVlO (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263690AbTDGVlO (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:41:14 -0400
Received: from fmr04.intel.com ([143.183.121.6]:61158 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263688AbTDGVlM (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 17:41:12 -0400
Message-ID: <C1B7430B33A4B14F80D29B5126C5E94701191AC5@orsmsx401.jf.intel.com>
From: "Mroczek, Joseph T" <joseph.t.mroczek@intel.com>
To: Abhishek Agrawal <abhishek@abhishek.agrawal.name>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: Strange e1000
Date: Mon, 7 Apr 2003 14:52:30 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2003-04-04 at 19:11, Paul Rolland wrote:

> Could it be possible that the 1000MBps FD on the e1000 side is
> a local configuration, and that it needs some time to discuss with
> the Netgear switch to negotiate correctly speed and duplex before
> working correctly ? (i.e. 20 sec = negotiation time)
Autoneg must be completed within 2 sec, or else it is considered as
failed.

It should be pointed out that there is a difference between completing
autonegotation and being able to pass traffic to other devices in the
network. The spanning tree and port fast settings have nothing to do with
autonegotiation. With port fast disabled on these switches, autonegotation
usually completes in the required 2s, but the switch does not pass frames to
the rest of the network until spanning tree assures loop free topology. The
NIC and switch port are actively passing traffic, but the switch is not
forwarding that traffic.

Hope this helps clarify.

~joe
