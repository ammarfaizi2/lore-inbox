Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267216AbSLRKbL>; Wed, 18 Dec 2002 05:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267217AbSLRKbL>; Wed, 18 Dec 2002 05:31:11 -0500
Received: from conductor.synapse.net ([199.84.54.18]:11273 "HELO
	conductor.synapse.net") by vger.kernel.org with SMTP
	id <S267216AbSLRKbJ> convert rfc822-to-8bit; Wed, 18 Dec 2002 05:31:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: "D.A.M. Revok" <marvin@synapse.net>
To: Manish Lachwani <manish@Zambeel.com>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133  Promise ctrlr, or...
Date: Wed, 18 Dec 2002 05:38:03 -0500
User-Agent: KMail/1.4.1
References: <233C89823A37714D95B1A891DE3BCE5202AB1B35@xch-a.win.zambeel.com>
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB1B35@xch-a.win.zambeel.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212180538.03296.marvin@synapse.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahem.

You /may/ want to remind me, next time, that umounting all filesystems 
except root, remounting root read-only, AND raid-stop'ing all arrays 
would be a good idea before doing this ( I forgot the last one )

Also, it seems that all drives de-allocate a sector every time I do this, 
and this is costing my system integrity...


Yes, it happens on all drives on the controller, and I've 2:
IBM 60GXP, 40GB == /dev/hde
Quantum LM15, 15GB == /dev/hdg

booting into multiuser command-line mode, no X, login as root, umount 
everything, "smartctl -a /dev/hde" ( or hdg ) gets 2 information lines, 
the second being the model# of the drive, and it never reaches the third 
line ( the newline doesn't appear ), and the drive-light comes on, and 
it's permanently hanged.

I'd thought this would be implicit in the 
* "cat /proc/ide/hde/identify" gets the same results *
comment I'd made previously, but did it out of curiosity...


When I did it on the Quantum, the Quantum's drive-light came on ( it's in 
a "mobile-rack" ), so it seems that the drive-light actually is still 
connected to the drive at that point, though nothing useful goes on 
after...


By the way, I seem to have hit this with the earlier 2.4.x kernels, ( 
IIRC ), but had /so/ much problems with flaky config and flaky distros 
at the time, that I didn't get that info out then ( by the time I got a 
stable system, I'd forgot, sorry... )


* Tell me which kernels you want me to try ( except ext3-broken ones ), 
and I'll do it, so you can scope where-the-break-is better, TIA *

     -me

On Tue 17 December, 2002 7:09, you wrote:
>Is it happening with all the drives on the controller? Is it possible
> to immediaately gather the SMART data from the drive after bootup
> using smartctl?
>
>Thanks
>Manish
>
>-----Original Message-----
From: D.A.M. Revok
>To: linux-kernel@vger.kernel.org
>Sent: 12/15/02 12:49 PM
>Subject: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133
>Promise ctrlr, or...
>
>( that's a capital-aye in the hdparm line )
>
>not even the Magic SysReq key will work.
>
>also, don't
>
>"cd /proc/ide/hde ; cat identify"
>
>... same thing
>drive-light comes on, but have to use the power-switch to get the
>machine
>back, ( lost stuff again, fuck )
>
>
>proc says it's pdc202xx
>
>Promise Ultra series driver Ver 1.20.0.7 2002-05-23
>Adapter: Ultra100 on M/B

-- 
http://www.drawright.com/
 - "The New Drawing on the Right Side of the Brain" ( Betty Edwards, 
check "Theory", "Gallery", and "Exercises" )
http://www.ldonline.org/ld_indepth/iep/seven_habits.html
 - "The 7 Habits of Highly Effective People" ( this site is same 
principles as Covey's book )
http://www.eiconsortium.org/research/ei_theory_performance.htm
 - "Working With Emotional Intelligence" ( Goleman: this link is 
/revised/ theory, "Working. . . " is practical )
http://www.leadershipnow.com/leadershop/1978-5.html
 - Corps Business: The 30 /Management Principles/ of the U.S. Marines ( 
David Freedman )
