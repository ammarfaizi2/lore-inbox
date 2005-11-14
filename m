Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVKNWOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVKNWOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 17:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVKNWOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 17:14:21 -0500
Received: from web50101.mail.yahoo.com ([206.190.38.29]:61103 "HELO
	web50101.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932199AbVKNWOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 17:14:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LFp/w6KPB5dV6NSLtUdOV33QZmaZCSbHzOtGbBavG7Za89WbkIc78cSv4m4/nl0nNhC8nWi4ZhshyCVVNt/5A+0cqW2DbKUwAn9RyfH6u821Lx4yu4dnRD0RiEPsJJGcciDBTlLaSqDkNsJQ3v2AAJpvzZKb37GgJy3wWJaLUHs=  ;
Message-ID: <20051114221419.10324.qmail@web50101.mail.yahoo.com>
Date: Mon, 14 Nov 2005 14:14:19 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [RFC] EDAC and the sysfs
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am trying to design the sysfs interface tree for the
new set of EDAC modules that are waiting for this
interface, before being put into the kernel.  

Currently the original EDAC (bluesmoke) has its own
/proc directory (/proc/mc) with files and a directory
(0,1,2,...)for each memory controller on the system.
This will be removed and the new information interface
will be placed in the sysfs.

One proposal is to place the information in
/sys/devices/system in the following directories:

For EDAC general memory ECC controls and information
files:

   /sys/devices/systems/edac/mc/

For PCI Parity Error detection controls and
information files:

   /sys/devices/system/edac/pci


In addition /sys/devices/system/edac/mc/ would  have
directories:

mc0/
mc1/
...

for each memory controller's specific controls and
information.


Currently the similiar error detection device
/sys/devices/system/machinecheck resides here are
well.


The alternative layout would be to use the /sys/class
directory when nested-classes become available:

/sys/class/edac/mc/...

and

/sys/class/edac/pci/...

But edac doesn't quite seem to fit here.

I have failed to date to really find a policy or set
of rules of use for the sysfs as to what goes where
for such items as EDAC. After searching the web,
articles and thinking about this for some time now, I
am requesting comments on the sysfs model for where
EDAC would fit best.

I currently favor the /sys/devices/system/edac
placement at the moment, but would welcome input.

thanks

doug thompson





"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

