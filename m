Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265068AbSKAPuF>; Fri, 1 Nov 2002 10:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265070AbSKAPuF>; Fri, 1 Nov 2002 10:50:05 -0500
Received: from washington.medstrat.com ([64.178.36.67]:54280 "EHLO
	washington.MEDSTRAT.medstrat.com") by vger.kernel.org with ESMTP
	id <S265068AbSKAPuE>; Fri, 1 Nov 2002 10:50:04 -0500
Message-ID: <5E9B153F549CE541915AE712D002079D291DF5@washington.medstrat.medstrat.com>
From: John McCash <jmccash@medstrat.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Multiterabyte Filesystem Support in 2.4.x on IA64?
Date: Fri, 1 Nov 2002 09:56:31 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I've searched through the lkml archives, and come up with
conflicting information on the topic of large filesystem support in 2.4.x.
What I'm interested in doing is a multiterabyte filesystem, using hardware
RAID arrays, connected via SCSI to an Intel-based host. My research
indicates that I MAY be able to do this if I use a 64 bit processor
architecture, and use either ext3 or xfs on top of LVM for the filesystem.
What's not clear currently, is whether I'm subject to the 2 terabyte file
size and filesystem size limitation.

	I suspect, but haven't been able to confirm, that these limits have
been raised from 1TB to 2TB (for IA32) by recent 2.4.x kernel versions,
largely by replacing signed values with unsigned ones. It's not at all clear
whether these limits apply to IA64, however. Apparently they did at one
time, as referenced by Peter Chubb's article on large filesystem support in
2.5.x in May of this year (www.gelato.unsw.edu.au/~peterc/lfs.html). I've
also come across a reference from last year
(http://lists.sistina.com/pipermail/linux-lvm/2001-September/008678.html
that suggests there are device specific patches that need to be applied to
make 64 bit sectoring work. It's not clear whether any or all of these have
since made their way into the stable kernel tree.

	So I'd appreciate if someone could explain what the current limits
actually are, and assuming the 2TB filesystem and file size limits do apply
in the generic case, are there any specific cases where they do not? If
anyone knows a hardware/software combination that definitely does allow
multiterabyte filesystem support, I'd love to hear about it. If the 2TB
limits do still apply to IA64, are they expected to go away anytime in the
near future of 2.4.x, or will I have to wait for 2.6? It will be in 2.6,
right?

	Please CC me on any replies, as I'm not subscribed to the list. I
know the FAQ (http://www.kernel.org/pub/linux/docs/lkml/#s9-13) says that
the limits do not apply to 64 bit CPUs, but as other information I've found
is at odds with that, I'd like clarification.
		Thanks very much
			John McCash
