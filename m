Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbTGTRJT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 13:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267557AbTGTRJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 13:09:19 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:531 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S267548AbTGTRJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 13:09:17 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Martin Schlemmer <azarah@gentoo.org>
Subject: Re: devfsd/2.6.0-test1
Date: Sun, 20 Jul 2003 21:17:32 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307202117.32753.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Agreed, it should. However, the last version I pulled had zero support for
>> probeall, and more importantly for probe, which is somewhat harder to do
>> cleanly without having to rewrite the config file for each kernel you
>> boot.
>> 
>
> Well, it implements probeall in another fashion.  Also, you might
> try /sbin/generate-modprobe.conf to convert a modules.conf to
> modprobe.conf syntax.

modprobe.conf syntax is easy to implement but unfortunately PITA to use. 
Exactly probe and probeall have been very helful in tracking module 
dependencies. Now you have arbitrary shell line that is near to impossible to 
parse in general.

I added half-hearted support to mkinitrd and initscripts for Mandrake but it 
will never be complete given the current situation.

Also I fixed devfsd to correctly use modprobe.devfs or modules.devfs depending 
on which kernel it runs on; patch has been sent both to lkml and devfs list 
and is included in current Mandrake devfsd.

actually adding probe and probeall is trivial enough, I did not want to base 
Mandrake packages on that to avoid incompatibility.

> Also, read the threads on the list about udev/hotplug - apparently
> devfsd is going out ...

as long as you have memory-based /dev you need devfsd even if it is called 
differently.

-andrey


