Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130464AbRAWNF5>; Tue, 23 Jan 2001 08:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130673AbRAWNFh>; Tue, 23 Jan 2001 08:05:37 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:5369 "HELO
	dark.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S130464AbRAWNFb>; Tue, 23 Jan 2001 08:05:31 -0500
To: Tigran Aivazian <tigran@veritas.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre8/10 klogd taking 100% of CPU time -- bug?
In-Reply-To: <Pine.LNX.4.21.0101231245140.916-100000@penguin.homenet>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 23 Jan 2001 14:05:36 +0000
In-Reply-To: <Pine.LNX.4.21.0101231245140.916-100000@penguin.homenet>
Message-ID: <m366j6mki7.fsf@giants.mandrakesoft.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.95
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian <tigran@veritas.com> writes:

> Yes, it works, but one should NOT forget to rename /sbin/syslogd ->
> syslogd.old and klogd likewise because the new versions install themselves

was not a problem for RPM since i did a RPM with the patch :

--=-=-=
From: Chmouel Boudjnah <devel@mandrakesoft.com>
Subject: [CHRPM] sysklogd-1.4-7mdk
To: Changelog List <changelog@linux-mandrake.com>
Date: Tue, 23 Jan 2001 12:30:13 +0100 (CET)

--=-=-=
Name        : sysklogd                     Relocations: (not relocateable)
Version     : 1.4                               Vendor: MandrakeSoft
Release     : 7mdk                          Build Date: Tue Jan 23 12:18:01 2001
Install date: (not installed)               Build Host: no.mandrakesoft.com
Group       : System/Kernel and hardware    Source RPM: (none)
Size        : 85062                            License: GPL
Packager    : Chmouel Boudjnah <chmouel@mandrakesoft.com>
Summary     : System logging and kernel message trapping daemons.
Description :
The sysklogd package contains two system utilities (syslogd and klogd)
which provide support for system logging.  Syslogd and klogd run as
daemons (background processes) and log system messages to different
places, like sendmail logs, security logs, error logs, etc.

--=-=-=

* Tue Jan 23 2001 Chmouel Boudjnah <chmouel@mandrakesoft.com> 1.4-7mdk

- Don't do busy loop when encounter two zero bytes (Troels Walsted
  Hansen (troels@thule.no)).

-- 
http://www.linux-mandrake.com/en/cookerdevel.php3
--=-=-=

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
