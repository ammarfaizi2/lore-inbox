Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269551AbRHHVKC>; Wed, 8 Aug 2001 17:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269549AbRHHVJz>; Wed, 8 Aug 2001 17:09:55 -0400
Received: from staff.zeelandnet.nl ([212.115.193.238]:40302 "EHLO
	staff.zeelandnet.nl") by vger.kernel.org with ESMTP
	id <S269542AbRHHVJ0> convert rfc822-to-8bit; Wed, 8 Aug 2001 17:09:26 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: x86 SMP and RPC/NFS problems
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Wed, 8 Aug 2001 23:09:21 +0200
Message-ID: <1C48875BDE7ED0469485A5FD49925C4AF01265@zmx.staff.zeelandnet.nl>
Thread-Topic: x86 SMP and RPC/NFS problems
Thread-Index: AcEgTmPgqd/HUFF2QZu9VU46ksKXNA==
From: "Alex Kerkhove" <alex.kerkhove@staff.zeelandnet.nl>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


We're running a quite busy mailserver (50.000 mailboxes, 170000+ msgs a
day) with maildir 'mailboxes' on an NFS volume. The server was running
redhat 7.1 with i686 2.4.3-12smp kernel.

Ever since the machine came into full production we've had big problems
on our dell 2540 dual p3-733, 1Gb RAM machine. At least twice a day we
would see nfs server timeouts, followed by "can't get request slot"
messages completeley hanging the machine and only a reboot could get the
system going again. We've tried every cure known to man to fix this
problem (changing nics, mount params, interal buffers, etc) no luck.


But when I switched to a Single processor kernel (RH 2.4.3-12) on the
same machine the problems where instantly solved! (13 days without
problems so far)


So my (blunt?) conclusion is that there must be some serious problems
with RPC/NFS (I guess RPC) and 2.4 SMP kernels! (and lots of processes
doing NFS stuff)


Anyone any thoughts on this?  My kernel hacking knowledge is limited,
but I'm willing to test patches :)

Thanks,

Alex


Please CC: me as I'm not subscribed to this list.
