Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265646AbSKAGpk>; Fri, 1 Nov 2002 01:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265647AbSKAGpk>; Fri, 1 Nov 2002 01:45:40 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:55512 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265646AbSKAGpj>; Fri, 1 Nov 2002 01:45:39 -0500
From: "Venkata Jagana" <jagana@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.45
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
Cc: davem@redhat.com, kkumar@beaverton.ibm.com, kuznet@ms2.inr.ac.ru,
       ajtuomin@tml.hut.fi, lpetande@tml.hut.fi, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFFA13F15A.27343A7E-ON88256C64.00238392@boulder.ibm.com>
Date: Thu, 31 Oct 2002 22:51:13 -0800
X-MIMETrack: Serialize by Router on D03NM036/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/31/2002 11:51:15 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> Registration process should live in user space.

I believe even the registration part should belong to kernel and
here are the reasons why.

The Home Agent needs to consult the Binding Cache, which is stored
upon successful completion of Binding updates registration, for
tunnelling the packets belonging to the mobile nodes away from home.
In addition, as part of the registration process but before caching
the binding updates, the Home Agent may need to perform duplicate address
detection (DAD), if needed, through ND protocol messages. And also,
IPSec is mandated for Home Agent registration and so, Home Agent
must use IPSec for responding to Binding updates from Mobile Nodes.


Thanks,
Venkat

----------------------------------------------------------------
Venkata R Jagana
IBM Linux Technology Centre, Beaverton
jagana@us.ibm.com
Tel: (503) 578 3430 T/L 775-3430



