Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTLDHYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 02:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTLDHYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 02:24:40 -0500
Received: from fmr06.intel.com ([134.134.136.7]:27278 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263142AbTLDHYi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 02:24:38 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Extremely slow network with e1000 & ip_conntrack
Date: Wed, 3 Dec 2003 23:24:24 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD20@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Extremely slow network with e1000 & ip_conntrack
Thread-Index: AcO4paDbQopOJrwLSfm5lMgBKgt5pABjVgugAAEHizA=
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Harald Welte" <laforge@netfilter.org>,
       "Stephen Lee" <mukansai@emailplus.org>
Cc: <netfilter-devel@lists.netfilter.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Dec 2003 07:24:25.0449 (UTC) FILETIME=[A5399D90:01C3BA37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > 2.4.22		82540EM		N
> > > > 2.5.26		82540EM		N
> > > > 2.5.46		82540EM		Y
> > > > 2.6.0-test10		82540EM		Y
> > > > 2.6.0-test11		82540EM		Y
> > > > 2.6.0-test11		82547EI		N
> > > > 2.4.22nptlsmp		82547EI		N
> 
> In e1000, check this out:
> 
>   #ifdef NETIF_F_TSO
>           if((adapter->hw.mac_type >= e1000_82544) &&
>              (adapter->hw.mac_type != e1000_82547))
>                   netdev->features |= NETIF_F_TSO;
>   #endif

Oh, I forgot one thing: 82540 is actually greater than 82544.  The
comparison is chronological order, not numerical.  This is the order the
controllers where released:

82542
82543
82544
82540
82545
82546
82541
82547

Don't ask.

-scott
