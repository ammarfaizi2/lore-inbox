Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSHGVrZ>; Wed, 7 Aug 2002 17:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSHGVrZ>; Wed, 7 Aug 2002 17:47:25 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:26961 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S313743AbSHGVrZ>; Wed, 7 Aug 2002 17:47:25 -0400
Date: Wed, 7 Aug 2002 16:51:05 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200208072151.QAA75961@tomcat.admin.navo.hpc.mil>
To: eli.carter@inet.com, linux-kernel@vger.kernel.org
Subject: Re: Idle curiosity: Acting as a SCSI target
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter <eli.carter@inet.com>:
> 
> Based on a conversation I had recently, my curiosity got piqued...
> 
> I'm not really sure how to query google on this, and didn't turn up what 
> I was looking for because of that, so here's the random question:
> 
> Is there a way to make a Linux machine with a scsi controller act like a 
> scsi device (is the correct term 'target'?) (such as a disk) using a 
> local block device as storage?
> 
> I'm not sure it would be of general use, but I can see uses in weird or 
> remote prototyping situations...
> 
> Like the subject says, just idle curiosity; I don't see having much use 
> for it, but I was intrigued by the idea.

Easy answer: yes

Harder answer - It was done a couple of years ago using an Adaptec controller,
and the implementation was used for a TCP stack allowing 180-200 MB/Sec network
layer. The network was about 4 feet long I believe.

Another use for such a thing: Using Linux for implementation of a hardware
RAID layer attached via SCSI cable.

A third use: short range distributed lock manager for a distributed filesystem
or NAS with a Linux based controller. This gets interesting when you start
adding security labels to the data, preventing unauthorized access to
partitions.

Much of the same applications can be done over GigE cards now, so the desire
to standardize a SCSI implementation waned.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
