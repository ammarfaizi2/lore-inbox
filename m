Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271628AbRHUKE7>; Tue, 21 Aug 2001 06:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271629AbRHUKEt>; Tue, 21 Aug 2001 06:04:49 -0400
Received: from NET.WAU.NL ([137.224.10.12]:64783 "EHLO net.wau.nl")
	by vger.kernel.org with ESMTP id <S271628AbRHUKEb>;
	Tue, 21 Aug 2001 06:04:31 -0400
Date: Tue, 21 Aug 2001 12:04:46 +0200
From: Olivier Sessink <olivier@lx.student.wau.nl>
Subject: NFS client doesn't reconnect to server - processes all hang
To: linux-kernel@vger.kernel.org
Message-id: <20010821120446.C5108@fender.fakenet>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
X-MSMail-priority: High
User-Agent: Mutt/1.2.5i
X-System-Uptime: 11:17am  up 8 days, 13:37,  2 users,  load average: 7.00,
 7.00, 6.97
X-Reverse-Engineered: High priority for sending SMS messages
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

accidently a NFS server (linux 2.4.8, Debian Woody, NFS-kernel server) was
shut down for a night, and one client (linux 2.2.19, Debian Potato) had
processes using a mounted export from that server.

Those processes are in State:  D (disk sleep) (according to
/proc/7434/status) and should be running again after the server is up
again. It was mounted without initr or soft, so the processes can't be
killed.

The server is up already for two days, and I can mount new exports from the
server, but that specific mount is still not alive, and 9 processes are
still waiting for it. How do I force the NFS client to bring that mount up?
How do I debug the current state to find out why the client thinks the
server is not up yet?

dmesg shows: nfs: task 21156 can't get a request slot 
so the client thinks the server is not responding.., but I can mount other
exports from that same server...........

any help/info/links is very much appreciated

regards,
	Olivier

