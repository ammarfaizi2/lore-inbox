Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVJAJUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVJAJUA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 05:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVJAJUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 05:20:00 -0400
Received: from vaxjo.synopsys.com ([198.182.60.75]:12207 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S1750781AbVJAJT7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 05:19:59 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: RH30: Virtual Mem shot heavily by locale-archive...
Date: Sat, 1 Oct 2005 14:49:48 +0530
Message-ID: <7EC22963812B4F40AE780CF2F140AFE916831E@IN01WEMBX1.internal.synopsys.com>
Thread-Topic: RH30: Virtual Mem shot heavily by locale-archive...
Thread-Index: AcXFwQqV68WIIDVURNqSXzKxYqL0qwAp6qJQ
From: "Arijit Das" <Arijit.Das@synopsys.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Arijit Das" <Arijit.Das@synopsys.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Oct 2005 09:19:55.0566 (UTC) FILETIME=[496CCCE0:01C5C669]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shared mappings are represented in /proc/<pid>/maps file as having 's'
as its last permission field like r-xs (shared readable and executable
region)

But in this case, the perm bits are r--p which says that it is private
rather than shared. Any idea whatz happening here...?

-Arijit

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Friday, September 30, 2005 7:13 PM
To: Arijit Das
Cc: linux-kernel@vger.kernel.org
Subject: Re: RH30: Virtual Mem shot heavily by locale-archive...

> This seems like a huge requirement of memory for each small process
executed in the RH3.0 system and hence, shots up the memory requirement
of the entire system because the mapped region
/usr/lib/locale/locale-archive is privately mapped.

There is no RH 3.0 for AMD64 - if you mean RHEL 3 then the mappings are
shared between processes.

