Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSI3QRb>; Mon, 30 Sep 2002 12:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262336AbSI3QRb>; Mon, 30 Sep 2002 12:17:31 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:64936 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262326AbSI3QR0>; Mon, 30 Sep 2002 12:17:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Michael Clark <michael@metaparadigm.com>
Subject: Re: v2.6 vs v3.0
Date: Mon, 30 Sep 2002 10:50:44 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <200209290114.15994.jdickens@ameritech.net> <02093008055700.15956@boiler> <3D9858AE.7080606@metaparadigm.com>
In-Reply-To: <3D9858AE.7080606@metaparadigm.com>
MIME-Version: 1.0
Message-Id: <02093010504404.15956@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 September 2002 08:59, Michael Clark wrote:
> Hi Kevin,
>
> On 09/30/02 21:05, Kevin Corry wrote:
> > EVMS is now up-to-date and running on 2.5.39. You can get the latest
> > kernel code from CVS (http://sourceforge.net/cvs/?group_id=25076) or
> > Bitkeepr (http://evms.bkbits.net/). There will be a new, full release
> > (1.2) coming out this week.
>
> Seems you guys are the furthest ahead for a working logical volume manager
> in 2.5. Does the EVMS team plan to send patches for 2.5 before the freeze?

Yes. We may send something in for review this week.

> It would be great to have EVMS in 2.5 (assuming the community approves of
> EVMS going in). Seems to be very non-invasive touching almost no common
> code.
>
> How far along are you with the clustering support (distributed locking of
> cluster metadata and update notification, etc)? This is what i'm really
> after.

Right now we are talking about ways to use EVMS in a fail-over cluster 
environment. E.g.: You have four nodes in a cluster each attached to a large 
SAN device. EVMS will provide software fencing of the shared storage so each 
node in the cluster will have a private portion of the SAN. EVMS will allow 
reassigning of storage to other nodes in the cluster in the event of a node 
failure. This approach involves the smallest hit to the existing code and 
very little extra kernel code.

More general cluster support, with support for fully-shared storage (and all 
of the necessary distributed locking and such) will come in 2003. This will 
obviously involve more in-depth code changes.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
