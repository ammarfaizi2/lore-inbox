Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269553AbRHHVZc>; Wed, 8 Aug 2001 17:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269546AbRHHVZX>; Wed, 8 Aug 2001 17:25:23 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:23047 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269545AbRHHVZF>; Wed, 8 Aug 2001 17:25:05 -0400
Message-ID: <3B71AF91.5577667E@zip.com.au>
Date: Wed, 08 Aug 2001 14:30:57 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Kerkhove <alex.kerkhove@staff.zeelandnet.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: x86 SMP and RPC/NFS problems
In-Reply-To: <1C48875BDE7ED0469485A5FD49925C4AF01265@zmx.staff.zeelandnet.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Kerkhove wrote:
> 
> Hi,
> 
> We're running a quite busy mailserver (50.000 mailboxes, 170000+ msgs a
> day) with maildir 'mailboxes' on an NFS volume. The server was running
> redhat 7.1 with i686 2.4.3-12smp kernel.
> 
> Ever since the machine came into full production we've had big problems
> on our dell 2540 dual p3-733, 1Gb RAM machine. At least twice a day we
> would see nfs server timeouts, followed by "can't get request slot"
> messages completeley hanging the machine and only a reboot could get the
> system going again. We've tried every cure known to man to fix this
> problem (changing nics, mount params, interal buffers, etc) no luck.

There were some SMP bugs in the NFS client code a while back but I
don't recall any on the server side.

Is it reproducible with 2.4.7?

What NICs have you tried?  If they were ne2k and/or 3com then
you've been bitten by the APIC bug.

-
