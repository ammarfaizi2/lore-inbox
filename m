Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277528AbRKSU2a>; Mon, 19 Nov 2001 15:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277382AbRKSU2U>; Mon, 19 Nov 2001 15:28:20 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:22458 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277528AbRKSU2H>; Mon, 19 Nov 2001 15:28:07 -0500
Message-ID: <3BF96A4E.FE21CC31@us.ibm.com>
Date: Mon, 19 Nov 2001 12:23:42 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Mike Kravetz <kravetz@us.ibm.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        lse-tech@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: Real Time Runqueue
In-Reply-To: <20011116154701.G1152@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0111161620050.998-100000@blue1.dev.mcafeelabs.com> <20011116163224.H1152@w-mikek2.des.beaverton.ibm.com> <3BF61AEB.2C186512@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> A couple of addition points.  There should be an API to declare cpu
> affinity, and cpu affinity should be passed thru fork and exec.  You may
> need to be god (root) to use the API however.  (I think cpu affinity is
> currently passed thru fork and exec, by the way.)

There is...  there is a launch_policy patch on
http://sourceforge.net/projects/lse, that offers 2 ways of setting a processes
CPU affinity.  A process can muck around with its own affinity through prctl(),
and root can muck around with the CPU affinity of any process through
/proc/<pid>/cpus_allowed and /proc/<pid>/launch_policy.  And the launch_policy
*is* inherited from parent to child.

The cpus_allowed part comes from Andrew Morton and controls the processes
affinity.  I've extended that to include the launch_policy part which sets the
affinity to be passed on through fork/exec.

Enjoy!

-matt
