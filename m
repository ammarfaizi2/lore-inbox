Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVKRWhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVKRWhq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVKRWhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:37:46 -0500
Received: from web50110.mail.yahoo.com ([206.190.38.38]:8873 "HELO
	web50110.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932116AbVKRWhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:37:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SV93cKCuXW3xQYTWgaceKdgHlOsyNIX0ZxszBLTNCzGimQxKQNPG8Zh+9zTOp1nw7mjciI+uOmYUj9wrESIazfiUfwE9gyCAW5FbRfc7RFQdXliGluCpjpddQruH+3Xu7ermMQPpTuI/hM1aAKZ8kokjv6+6sN84jXwYpWhOizo=  ;
Message-ID: <20051118223744.88496.qmail@web50110.mail.yahoo.com>
Date: Fri, 18 Nov 2005 14:37:44 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [RFC] EDAC and /sys/devices/system
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I have been playing now with the sysdev class of
APIs for installing objects into /sys/devices/system.
Unforturnately, the capabilities of that do not
provide me with what I was wanting for EDAC.

What I was wanting was an extra directory called
'edac'. In that directory was to be various types of
edac devices (memory controller and PCI Parity to
start)

In the directory /sys/devices/system:

edac/mc/mc0/<attr and controls>
edac/mc/mc1/<attr and controls>
edac/mc/<attr and controls>

and

edac/pci/<attr and controls>

This would allow for future edac components.

What I found out was that /sys/devices/system doesn't
allow for nested subsystems. At least not from what I
have read.

With the current APIs I can have the following in
/sys/devices/system:

edac_mc/edac_mc0/<attr and controls>
edac_mc/edac_mc1/<attr and controls>
edac_mc/<attr and controls>

and

edac_pci/edac_pci0/<attr and controls>


One solution is to add to the sysdev.c API set, but I
just don't want to go there. 

So, it seems that what I can implement is the last set
of layout
above.

Thoughts?

Thanks

doug t



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

