Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWAYQco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWAYQco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 11:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWAYQco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 11:32:44 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:13238 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750972AbWAYQco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 11:32:44 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 25 Jan 2006 17:31:48 +0100
To: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D7A7F4.nailDE92K7TJI@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
In-Reply-To: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <acahalan@gmail.com> wrote:

> We Linux users will forever patch your software to work the

Looks like you are not a native English speaker. "We" is incorrect here, as you 
only speak for yourself.


> BTW, before Joerg mentions portability, I'd like to remind
> everyone that all modern OSes support the use of normal device
> names for SCSI. The most awkward is FreeBSD, where you have
> to do a syscall or two to translate the name to Joerg's very
> non-hotplug non-iSCSI way of thinking. Windows, MacOS X, and
> even Solaris all manage to handle device names just fine. In
> numerous cases, not just Linux, cdrecord is inventing crap out
> of thin air to satisfy a pre-hotplug worldview.

Looks like you are badly informed, so I encourage you to get yourself informed 
properly before sending your next postig....

libscg includes 22 different SCSI low level transport implementations.

-	Only 5 of them allow a /dev/hd* device name related access.

-	11 of them use file descriptors as handles for sending SCSI 
	commands but do not have a name <-> fs relation and thus
	_need_ a SCSI device naming scheme as libscg offers.
	This is because there is no 1:1 relation between SCSI addressing
	and a fd retrieved from a /dev/* entry.

-	6 of them not even allow to get a file descriptors as handles for 
	sending SCSI commands. These platforms of course need the SCSI device 
	naming scheme as libscg offers.

Conclusion:

17 Platforms _need_ the addressing scheme libscg offers

5  Platforms _may_ use a different access method too.

NOTE: Amongst the 6 plaforms that do not allow to even get a file descriptor 
there is a modern OS like MacOS X


BTW: the wording of your posting did give you a negative score.
If you continue the same way, it may be that your next posting will 
remain unanswered even though it may be wring and needs a correction like this 
one.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
