Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVAKLiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVAKLiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 06:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVAKLiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 06:38:46 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:34932 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S262727AbVAKLio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 06:38:44 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-Id: <5.1.0.14.2.20050111223726.044844e8@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 11 Jan 2005 22:38:35 +1100
To: Neil Brown <neilb@cse.unsw.edu.au>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Linux NFS vs NetApp
Cc: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <16867.41549.618.539945@cse.unsw.edu.au>
References: <message from Phy Prabab on Monday January 10>
 <20050111025401.48311.qmail@web51810.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:54 PM 11/01/2005, Neil Brown wrote:
>On Monday January 10, phyprabab@yahoo.com wrote:
> > Hello!
> >
> > I am trying to understand how NetApp can be so much
> > better at NFS servicing than my quad Opteron 250 SAN
> > attached machine.  So I need some help and some
> > pointers to understand how I can make my opteron
> > machine come on par (or within 70% NFS performance
> > range) as that of my NetApp R200.  I have run through
> > the NFS-how-to's and have heard "that is why they cost
> > so much more", but I really have to consider that
> > probably most of the ideas that are in the NetApp are
> > common knowldge (just not in my head).
> >
> > Can anyone shed some light on this?
>
>If you want to come anything close to comparable with a Netapp, get a
>few hundred Megabytes of NVRAM (e.g. www.umem.com), and configure it
>as an external journal for your filesystem (I know this can be done
>for ext3, I don't know about other filesystems).  Then make sure your
>filesystem journals all data, not just metadata (data=journal option
>to ext3).

NetApp's WAFL only journals metadata in NVRAM ...
(one of the primary reasons its called WAFL is that the data-write only 
happens once..).


cheers,

lincoln.
