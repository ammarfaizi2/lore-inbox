Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNMcS>; Wed, 14 Feb 2001 07:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132011AbRBNMcI>; Wed, 14 Feb 2001 07:32:08 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:63492 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129051AbRBNMbz>;
	Wed, 14 Feb 2001 07:31:55 -0500
Date: Wed, 14 Feb 2001 13:31:44 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: block ioctl to read/write last sector
To: Michael E Brown <michael_e_brown@dell.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3A8A7AB0.5D483D5F@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael E Brown (michael_e_brown@dell.com) worte :

> On Wed, 14 Feb 2001, Manfred Spraul wrote:
>
> > I have one additional user space only idea: 
> > have you tried raw-io? bind a raw device to the partition, IIRC raw-io 
> > is always in 512 byte units. 
> 
> That has been tried. No, it does not work. :-) Using Scsi-Generic is the
> only way so far found, but of course, it only works on SCSI drives.

Did you try scsi-emulation on IDE disks ?
 
> > 
> > Probably an ioctl is the better idea, but I'd use absolute sector 
> > numbers (not relative to the end), and obviously 64-bit sector numbers - 
> > 2 TB isn't that far away. 
> > 
> 
> I was deliberately trying to limit the scope to avoid misuse. This is to
> work around a flaw in the current API, not to create a new API. Limiting
> access to only those blocks that would normally be inaccessible through
> the normal API seemed like the best bet to me.


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
