Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269923AbTGPANJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 20:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269933AbTGPANJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 20:13:09 -0400
Received: from fmr05.intel.com ([134.134.136.6]:38114 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S269923AbTGPANH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 20:13:07 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [patch] e1000 TSO parameter
Date: Tue, 15 Jul 2003 17:27:56 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010222917D@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] e1000 TSO parameter
Thread-Index: AcNKkXfnLmDm+gDET0axp1OGYzd6LwAnoLlw
From: "Feldman, Scott" <scott.feldman@intel.com>
To: <davidm@hpl.hp.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
X-OriginalArrivalTime: 16 Jul 2003 00:27:56.0650 (UTC) FILETIME=[1A7EBCA0:01C34B31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> TSO disabled:
> 
>  $ modprobe InterruptThrottleRate=0,0,0,0 TSO=0,0,0,0

If you're trying to remove all interrupt moderation, you'll also want to
add these:

RxIntDelay=0,0,0,0 RxAbsIntDelay=0,0,0,0 TxIntDelay=0,0,0,0
TxAbsIntDelay=0,0,0,0

See the app note here for more info:
http://www.intel.com/design/network/applnots/8254x_ap450.htm

-scott

