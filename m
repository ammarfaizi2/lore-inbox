Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbTDZMHn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 08:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbTDZMHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 08:07:43 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:37636 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263033AbTDZMHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 08:07:42 -0400
Date: Sat, 26 Apr 2003 14:20:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: linux-kernel@vger.kernel.org
Cc: sp@osb.hu
Subject: Re: [PATCH 2.4] dmi_ident made public
Message-Id: <20030426142002.70c0daf6.khali@linux-fr.org>
In-Reply-To: <1051265517.5460.11.camel@dhcp22.swansea.linux.org.uk>
References: <20030424184759.5f7b3323.khali@linux-fr.org>
	<20030424231028.GA29393@kroah.com>
	<20030425121517.28c9002b.khali@linux-fr.org>
	<1051265517.5460.11.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > What's more, I plan to write another module that exports the DMI
> > data, as scanned at boot time, to userland (via sysfs), and such a
> > module definitely requires that the DMI data is made public in
> > dmi_scan.
> 
> I suspect the DMI module should itself do the sysfs interface, and I 
> certainly think the idea of it being in sysfs has merit.

I was not really sure about this. There are two issues that would need
to be discussed:
1* Including it into dmi_scan makes it impossible to be a module, at
least with my knowledge of the modules mechanics. Correct me if I'm
wrong.
2* There is a need for dmi scanning on IA-64 systems, where locating the
DMI table follows a different scheme from what we do for i386 systems.
Having a platform-independant module for the sysfs stuff would save us
from code duplication (which is precisely what I am trying to avoid
here).
I don't know how much of a concern these two points are, and any light
will be appreciated.

Anyway, I think this is almost a completely different problem from the
one I first posted about. There still are two modules around (i8k and
omke) that would take great benefit of the simple patch I submitted some
days ago. So, unless there is any motivated objection against it (such
as an alternative solution I wouldn't have thought about), I'd still
like to see the above mentioned patch applied, since it would give us
the possibility to remove all the duplicated code (more than 100 lines
per module).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
