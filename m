Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268296AbTGTUrU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 16:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268396AbTGTUrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 16:47:19 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:46436 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S268296AbTGTUrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 16:47:02 -0400
Subject: [NETWORKING] Re: More ACPI funnies in 2.6.0test1
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1058714000.2488.2.camel@aurora.localdomain>
References: <1058714000.2488.2.camel@aurora.localdomain>
Content-Type: text/plain
Message-Id: <1058734920.3012.9.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 20 Jul 2003 17:02:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I was mistaken.  ACPI has nothing to do with it.  I got an actual
oops on shutdown without it.  It was in the ip 6 routing code.  Attached
is a bunch of alt-sysrq-p from when it gets stuck trying to down eth0. 
The program running at the time was ip... said something like ip 6 route
del in ps xa.  That was the program running.  The oopses were induced,
it is gzip because I have so many.  I will try to trigger the real oops
and show it here in this thread.

Actually, I will attach the log after I know that P and T in sysrq don't
leak passwords and such.  I am not entirely sure what is or isn't in
something like:

Jul 20 11:35:08 aurora kernel: spamd         S DBFB73FC 4278501676 
2156      1          2165  2145 (NOTLB)
Jul 20 11:35:08 aurora kernel: daed9eb4 00000082 daed9f44 dbfb73fc
c0137e13 c110fa18 dbe8d300 00000000 
Jul 20 11:35:08 aurora kernel:        7fffffff 00000006 00000006
c0123951 c02562a4 dbae8190 dbfb73fc daed9f44 
Jul 20 11:35:08 aurora kernel:        c0320880 00000020 00000005
00000005 c0232e59 dbae8190 dbfb73e4 00000000 

Anyway, I will continue to try and get a real oops.  I will post this
once someone lets me know it is safe.

Trever

On Sun, 2003-07-20 at 11:13, Trever L. Adams wrote:
> Alright, same board here, Asus A7N8X-Deluxe (nVidia nForce 2).  I have
> pci=noacpi.  However, if I leave ACPI on, I get two funnies:
> 
> 1) My disk seems to be more active, I hear it clicking much more
> 2) When eth0 gets shutdown on power off, it freezes.  However, I just
> tried to force it by manually shutting it off and it works fine.
> 
> I will provide the sysrq output later today when I will have more paper
> around to write down the output.
> 
> This box works fine with pci=noacpi and acpi=off.  So, I am just trying
> to figure out how to get it to work fine with the power stuff working,
> even if the irq related part is broken.  It would be nice to fix it all
> actually.
> 
> Trever
> --
> "It was as true as taxes is. And nothing's truer than them." -- Charles
> Dickens (1812-70)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
"The era of setting this up as a competition between Apple and Microsoft
is over, as far as I'm concerned." -- S. Jobs

