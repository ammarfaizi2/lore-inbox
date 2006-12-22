Return-Path: <linux-kernel-owner+w=401wt.eu-S1752451AbWLVVjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbWLVVjb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWLVVjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:39:31 -0500
Received: from mga03.intel.com ([143.182.124.21]:28550 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451AbWLVVja convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:39:30 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,206,1165219200"; 
   d="scan'208"; a="161702771:sNHT8241271514"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.6.19-rt14 slowdown compared to 2.6.19
Date: Fri, 22 Dec 2006 13:39:15 -0800
Message-ID: <9D2C22909C6E774EBFB8B5583AE5291C0199950A@fmsmsx414.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rt14 slowdown compared to 2.6.19
Thread-Index: AccmEaB0Al/cOvZxTXWOb22wf8dWOw==
From: "Chen, Tim C" <tim.c.chen@intel.com>
To: <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
X-OriginalArrivalTime: 22 Dec 2006 21:39:19.0059 (UTC) FILETIME=[A2C6DE30:01C72611]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,
 
We did some benchmarking on 2.6.19-rt14, compared it with 2.6.19 
kernel and noticed several slowdowns.  The test machine is a 2 socket
woodcrest machine with your default configuration.
 
Netperf TCP Streaming was slower by 40% ( 1 server and 1 client 
each bound to separate cpu cores on different socket, network
loopback mode was used).  

Volanomark was slower by 80% (Server and Clients communicate with 
network loopback mode. Idle time goes from 1% to 60%)

Re-Aim7 was slower by 40% (idle time goes from 0% to 20%)

Wonder if you have any suggestions on what could cause the slowdown.  
We've tried disabling CONFIG_NO_HZ and it didn't help much.

Thanks.

Tim
