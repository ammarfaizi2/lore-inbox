Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTIQCGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 22:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbTIQCGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 22:06:10 -0400
Received: from fmr09.intel.com ([192.52.57.35]:56267 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262589AbTIQCGI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 22:06:08 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] Net device error logging, revised
Date: Tue, 16 Sep 2003 19:06:01 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010124F051@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Net device error logging, revised
Thread-Index: AcN73qqL6xcF06HFQk+v7BYiIraw8AA4GNpg
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Jim Keniston" <jkenisto@us.ibm.com>,
       "LKML" <linux-kernel@vger.kernel.org>, "netdev" <netdev@oss.sgi.com>,
       "Jeff Garzik" <jgarzik@pobox.com>, "Larry Kessler" <kessler@us.ibm.com>,
       "Greg KH" <greg@kroah.com>, "Randy Dunlap" <rddunlap@osdl.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Andrew Morton" <akpm@osdl.org>
Cc: "David Brownell" <david-b@pacbell.net>,
       "Stephen Hemminger" <shemminger@osdl.org>
X-OriginalArrivalTime: 17 Sep 2003 02:06:02.0206 (UTC) FILETIME=[3E958FE0:01C37CC0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 3. A new macro, netdev_fatal, is included.  Given the call
>         netdev_fatal(dev, HW, "NIC fried!\n");
> the indicated message is always logged: the msglevel arg (HW, in this
> case) is NOT consulted.  In fact, the msglevel arg to netdev_fatal
> is ignored in this implementation.  (As previously discussed, in some
> future implementation, the msglevel could be logged to help indicate
> the circumstances under which the event was logged.)

I couldn't find the previous discussion on netdev_fatal, so sorry if
this has already been worked out.  It uses KERN_ERR; did you mean
something stronger?  If not, why not just use netdev_err(dev, ALL,
"...")?  What is the situation in the driver where we'd want to use
_fatal?  How do I know when to use _fatal and when to use _err?

-scott
