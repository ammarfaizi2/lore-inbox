Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318697AbSHAN2U>; Thu, 1 Aug 2002 09:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318737AbSHAN2U>; Thu, 1 Aug 2002 09:28:20 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:39358 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318697AbSHAN2T>; Thu, 1 Aug 2002 09:28:19 -0400
Subject: Re: [Lse-tech] [RFC]  per cpu slab fix to reduce freemiss
To: dipankar@beaverton.ibm.com
Cc: Bill Hartner <Bill_Hartner@us.ibm.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>,
       "Luck, Tony" <tony.luck@intel.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF6D440764.727DFE3C-ON87256C08.0049B06D@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Thu, 1 Aug 2002 08:31:45 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/01/2002 07:31:39 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dipankar wrote..
>Isn't it possible to tune the cpucache limit by writing to
>/proc/slabinfo so that you avoid frequent draining of free objects ?
>Am I missing something here ?

Are you referring to raising the per cpu array limit? I don't think you
tune that using /proc/slabinfo.  However that does not solve the problem,
it only delays it.  It needs to grow/shrink dynamically based on need. I
am not only referring to frequently draining of free objects but also
as a result of this refilling the object array due to subsequent
allocations and so on.

Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   Phone:838-8088; Tie-line:678-8088






