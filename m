Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTKKEBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 23:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbTKKEBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 23:01:42 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:28841 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264252AbTKKEBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 23:01:40 -0500
From: "Joseph Shamash" <info@avistor.com>
To: "Mike Fedyk" <mfedyk@matchmail.com>,
       "Peter Chubb" <peter@chubb.wattle.id.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2 TB partition support
Date: Mon, 10 Nov 2003 20:03:53 -0800
Message-ID: <HBEHKOEIIJKNLNAMLGAOOEDFDKAA.info@avistor.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <16304.23206.924374.529136@wombat.chubb.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>What exactly are you trying to do?

Doing testing in our lab trying to use 2.4.x and 2.6.
Trying to see how high a storage capacity can be supported
above 2TB, both in partitions and file sizes.

The limitation we have found in 2.4 is lack of 2TB support,
(using hardware raid with 2TB+ partitions).

The limitation we have found in 2.6 is lack FC HBA drivers which 
are needed to support large storage capacities.

Any thoughts?


-----Original Message-----
From: Peter Chubb [mailto:peterc@chubb.wattle.id.au]On Behalf Of Peter
Chubb
Sent: Monday, November 10, 2003 7:43 PM
To: Mike Fedyk
Cc: Joseph Shamash; Peter Chubb; linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support


>>>>> "Mike" == Mike Fedyk <mfedyk@matchmail.com> writes:

> On Mon, Nov 10, 2003 at 06:12:06PM -0800, Joseph Shamash wrote:
>> 
>> What is the maximum partition size for a patched 2.4.x kernel, and
>> where are those patches?

Mike> I believe it is now 16TB per block device in 2.6, and patched
Mike> 2.4.

That's right for 32-bit systems with 4k pages.  For 64 bit systems the
limit is over 8 Exabytes.

You should note that software raid has smaller limits, as does the
LVM.  Also the 2.4 patches have seen *much* less testing than the 2.6
mainline (except possibly on the SGI Altix).

What exactly are you trying to do?

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*



