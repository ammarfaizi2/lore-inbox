Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312805AbSDFVSr>; Sat, 6 Apr 2002 16:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312813AbSDFVSq>; Sat, 6 Apr 2002 16:18:46 -0500
Received: from gw.wmich.edu ([141.218.1.100]:23944 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S312805AbSDFVSp>;
	Sat, 6 Apr 2002 16:18:45 -0500
Subject: Re: more on 2.4.19pre... & swsusp
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: brian@worldcontrol.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020406200918.GA1535@top.worldcontrol.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 06 Apr 2002 16:18:38 -0500
Message-Id: <1018127923.4270.60.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-06 at 15:09, brian@worldcontrol.com wrote:
> I found a .config difference between my 2.4.19-pre5-ac3 setup
> and my 2.4.19-pre6 (swsusp v0.8 patched) setup.
> 
> After making both the same, both generally oops in the same place
> as previously reported (oops via ksymoops previously posted).
> 
> Findings thus far:
> 
>    swsusp says it doesn't need APM. But it does. at least so far
>    as menuconfig is concerned.
This is an error in the AC branch.   WOLK 3.2 configs fine.


>    With apm loaded (or built) in the kernel swsusp says it can't
>    terminate/kill kapmd and gives up.
> 
>    With apm *not* loaded in the kernel swsusp oopses as previously
>    reported.
> 
> Nice repeatable behavior.
> 
> Documentation/swsusp.txt which is repeatedly refered to does not
> exist, either in the ac version or the v0.8 patch.

Does not exist in the WOLK 3.2 release either. all documentation on
swsusp is horribly outdated.  I believe the website posts 2.4.9 as the
latest kernel it's been patched against. 

> I have not been able to find the swsusp program which is also
> refered to.

all programs are simply scripts people have written to fascilitate
suspending or resuming.  (turning off dma before suspending and such).  


swsusp does not need apm or acpi.  IT does need magic sysrq or acpi
however.  Which is something that's not quite documented.  Ie. You can't
do sysrq d (c in WOLK) if you dont have magic sysrq compiled in.  And
you can't echo "4" > /proc/acpi/sleep if you dont have acpi.  So one or
the other is required.  This could be an example of why they're putting
in a new build system for 2.5.  


swsusp works for me in wolk3.2 but it doesn't use rmap. Seems like the
swsusp patch was just hacked into ac so it would compile with little to
no changes from wolk3.2.   

Wolk 3.2 also uses the memeat patch which the list describes as being
necessary for many people to not oops on suspend.   This is not in the
ac branch.  


On a different note.  Why doesn't the ac branch have ftpfs yet?  Besides
the fact that it sometimes has problems with ls'ing a directory because
of a . handle error,  using mc to navigate works perfectly.  It deserves
a wider test audiance. Mounting ftp sites is a so amazingly convenient
it's hard to overestimate the coolness of ftpfs.  It patches cleanly
against the current ac as is.  

http://ftpfs.sourceforge.net/ 

