Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbTAIOcF>; Thu, 9 Jan 2003 09:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbTAIOcF>; Thu, 9 Jan 2003 09:32:05 -0500
Received: from [81.2.122.30] ([81.2.122.30]:6917 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266721AbTAIOcC>;
	Thu, 9 Jan 2003 09:32:02 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301091440.h09Eeln1001368@darkstar.example.net>
Subject: Re: [ANNOUNCE] Kernel Bug Database V1.10 on-line
To: jbglaw@lug-owl.de (Jan-Benedict Glaw)
Date: Thu, 9 Jan 2003 14:40:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030109134755.GE2529@lug-owl.de> from "Jan-Benedict Glaw" at Jan 09, 2003 02:47:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Version 1.10 of my kernel bug database is now on-line at:
> > http://grabjohn.com/kernelbugdatabase/
> 
> > If the original submitter of a bug uploaded their config file, you can
> > download a config file with the same options set.
> 
> What do I get? His/her config file, or some other?

No, you don't just get a copy of the original config file:

When a config file is uploaded to the system, it's parsed and the
actual config options are stored in a database.  If comments are
present in a form that resembles what the existing kernel
configurators use to indicate different sections, then those comments
are used to categorise the config options in the database.

The main reason for this is so that if somebody reports a bug, and
includes their config information, a developer can select one of their
config options from a list, and indicate that the bug is triggered by
it.

Re-generating the config file from that database, so that somebody
else can download it was added as an afterthought :-).  Comments are
re-inserted, as well as an additional comment showing which kernel
version the config was originally intended for.

> One can watch certain subsystems/drivers. That's a _really_ nice
> feature, and I'd even like to be notified if a file belonging to one of
> "my" choosen subsystems is to be changed on mainstream. However,
> choosing subsystems of interest isn't quite fun because of the entrie's
> order.
> 
> I'd do this with three parts (within one list):
> 
> ARCH - ALPHA
> ARCH - SPARC
> ARCH - ...
> 
> Then important subsystems:
> FS-Core
> INIT
> NET
> NET-IPv4
> NET-IPv6
> NET-xxx
> PCI
> SCSI
> IDE
> =2E..
> 
> =2E..and at last, I'd list all chooseable drivers:
> 3c509
> cpuid
> ACPI
> APM
> FS - AFS
> FS - EXT2
> FS - EXT3
> FS - codepages
> =2E..

Well, at the moment, the list is just generated from the MAINTAINERS
file, I didn't want to introduce my own grouping of things, but it
really depends on what people want.

I could add the ability to watch via config options as well as the
list of maintainers, would that be helpful?

> That would really ease finding the interesting parts. Where, for
> example, can I go for sparc?

Hmm, good point, there is only an UltraSPARC maintainer listed.  The
problem is, this is a problem with the MAINTAINERS file that my
database has inherited - do we fix the MAINTAINERS file or my db?

John.
