Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUBDUOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbUBDUOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:14:18 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:1582 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S264898AbUBDUON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:14:13 -0500
Subject: Re: Active Memory Defragmentation: Our implementation & problems
To: root@chaos.analogic.com
Cc: Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Timothy Miller <miller@techsource.com>,
       owner-linux-mm@kvack.org, Alok Mooley <rangdi@yahoo.com>
X-Mailer: Lotus Notes Release 5.0.9  November 16, 2001
Message-ID: <OFE7103176.29D4436D-ON86256E30.006E41D8@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Wed, 4 Feb 2004 14:12:17 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.0.2CF2|July 23, 2003) at
 02/04/2004 02:13:09 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Richard B. Johnson wrote:

>Eventually you
>get to the fact that even contiguous physical RAM doesn't
>have to be contiguous and, in fact, with modern controllers
>it's quite unlikely that it is. It's a sack of bits that
>are uniquely addressable.

Yes and no. We are using a shared memory interface on a cluster that allows
us to map up to 512 Mbytes of memory from another machine. There are 16k
address translation table (ATT) entries in the card, so we're allocating
32K chunks of memory per ATT. We are using the bigphysarea patch for the
driver (in 2.4 kernels) only because the driver can't reliably get the
chunks of RAM it is asking for. We can continue to operate the way we've
been doing or get a mechanism to defragment physical RAM so the driver can
continue to work a week after we rebooted the machine.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

