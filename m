Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbUA0Iwl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 03:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbUA0Iwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 03:52:41 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:4093 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S262705AbUA0Iwj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 03:52:39 -0500
Subject: Re: Cset 1.1490.4.201 - dasd naming
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: laroche@redhat.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFCE30A640.024A04A1-ONC1256E28.003023EA-C1256E28.0030BF4E@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 27 Jan 2004 09:52:27 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 27/01/2004 09:52:30
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,

> In a recent changeset in Linus' tree, there's your diff which blows up
> the dasd naming scheme, with the comment:
>  - Change dasd names from "dasdx" to "dasd_<busid>_".
We plan to do this for tape and other ccw devices as well (where applicable).

> This breaks mkinitrd, nash, and mount by label (not to mention every
> zipl.conf out there, because root= aliases to /sys/block/%s).
> Would you please explain what exactly you were thinking when you
> submitted that patch?
The reason for this change is the requirement to have persistent device
names. The /dev/dasdxyz naming schema heavily depends on the order in
which the device are added. Not good for persistent names. This change
affects four things: 1) the internal name, 2) the name of the sysfs
directory, 3) the root= parameter and 4) the hotplug events for dasd
devices.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com



