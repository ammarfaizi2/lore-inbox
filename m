Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVIGSDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVIGSDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVIGSDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:03:38 -0400
Received: from mail.cs.umn.edu ([128.101.32.202]:27349 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S932089AbVIGSDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:03:37 -0400
Date: Wed, 7 Sep 2005 13:03:33 -0500
From: Dave C Boutcher <sleddog@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [Patch 0/4] [RFC] Resend SCSI target for IBM Power5 LPAR
Message-ID: <20050907180333.GA12904@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dog ate my homework.  No, that's not it, the mailer ate my patches.
In any case, since most of the mailing list mailers ate my (>100K) 
patches, here's the same thing broken up.

his device driver provides the SCSI target side of the "virtual
SCSI" on IBM Power5 systems.  The initiator side has been in mainline
for a while now (drivers/scsi/ibmvscsi/ibmvscsi.c.)  Targets already
exist for AIX and OS/400.

One of the biggest discussions, I expect, will be whether much of
this belongs in user-land.  We have had considerable debates on that
subject, and ended up with it all in the kernel.  Unlike some other
targets (e.g. iSCSI) that sit on top of nice TCP/IP stacks, this one
interacts at a pretty low level with the firmware.  There weren't
any good user-land splits that seemed to make sense (and looking at
the history of the NFS server also influenced the discussion.)

This is currently just an RFC...if my boxers survive the flamage
I'll submit it for inclusion.

As an additional note, Cristoph already pointed me to Mike Christie and
Tomonori Fujita who are doing some similar work

Thanks

Dave B

