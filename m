Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbSLTSbu>; Fri, 20 Dec 2002 13:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbSLTSbu>; Fri, 20 Dec 2002 13:31:50 -0500
Received: from conductor.synapse.net ([199.84.54.18]:18703 "HELO
	conductor.synapse.net") by vger.kernel.org with SMTP
	id <S263977AbSLTSbr> convert rfc822-to-8bit; Fri, 20 Dec 2002 13:31:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: "D.A.M. Revok" <marvin@synapse.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Right, I tried flashing the BIOS, as suggested, and /still/ can't enable SMART
Date: Fri, 20 Dec 2002 13:38:45 -0500
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212201338.45492.marvin@synapse.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on the Promise U100 controller without blowing the system - terminally.

I give up.

According to what I can figure-out from the programmers' comments, it 
/isn't possible/ to correct that with the Promise chip, because of some 
peculiarity they engineered-in,... BUT...

When the motherboard's BIOS initializes the chip I /can/ enable SMART, 
but then...

I can't boot without having my boot-system on /dev/hde, rather than 
/dev/hda...

Fuck it.

I /think/ that if the BIOS can initialize the Promise chip, that it is 
(theoretically) possible for the kernel to initialize the chip to 
function correctly, but if Promise /won't allow/ paid-for chips to 
function in a way that gives us the reliability-system we paid-for, then 
the simplest solution is:

1. note it in the config helpfile ( Promise-controller-section ) to NEVER 
cat /proc/ide/hde/identify
smartctl -e
smartctl -a
hdparm -I ( capital i )
&c.
unless the Promise-BIOS is enabled in the motherboard's BIOS settings ( 
this will reduce systems trashed due-to-ignorance in linux )

2. cease buying Promise chip-based systems for reliable-systems running 
linux, until they decide that customers are good, IF they decide 
customers are good...

3. maybe see what the mobos BIOS does and see if the kernel-driver could 
do that to get SMART to be useable on these chips irregardless ( 
love-that-word ) of the BIOS's settings

Thanks for helping me understand, and as Jeff Dunteman says...

   Keep on hacking

      -me

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
