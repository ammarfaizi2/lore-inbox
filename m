Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUAONO7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 08:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266489AbUAONO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 08:14:59 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:48796 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S266481AbUAONO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 08:14:57 -0500
Date: Thu, 15 Jan 2004 14:14:55 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6 NFS stale filehandle with subtree_check
Message-ID: <20040115141454.B17239@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello all,

	I have a NFS fileserver (currently based on XFS on 3ware RAID),
which I have tried to upgrade to 2.6. kernel. After reboot, clients
started to see partial directories, or cannot open/create files in
their cwd, with the "stale NFS file handle" message. Using no_subtree_check
option in /etc/exports helped, as well as going back to 2.4+XFS.

	It is probably not XFS related, because I had the same problem
on an older HW of this server (which had an ext3 volumes on software RAID)
and some 2.6.0-pre kernel. At that time I did not know that I had to try
no_subtree_check, so I don't know whether this would have fixed the
problem on the older HW. I went back to 2.4 then.

	The machine serves the home directories via NFS and Samba.
I have home directories for ~2200 users there, each one with its own
/etc/exports entry[1]. NFS clients are various Linux, Solaris and IRIX
workstations and servers.

	Is it possible to use subtree_check in NFS in 2.6? Thanks,

-Yenya

[1] For another unrelated user-space problem with such a big /etc/exports,
see http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=76643

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|  I actually have a lot of admiration and respect for the PATA knowledge  |
| embedded in drivers/ide. But I would never call it pretty:) -Jeff Garzik |
