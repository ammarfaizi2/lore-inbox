Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUFGNij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUFGNij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbUFGNii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 09:38:38 -0400
Received: from mail.scienion.de ([141.16.81.54]:4315 "EHLO
	server03.hq.scienion.de") by vger.kernel.org with ESMTP
	id S262648AbUFGNhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 09:37:08 -0400
Message-ID: <40C46F7F.7060703@scienion.de>
Date: Mon, 07 Jun 2004 15:37:03 +0200
From: Sebastian Kloska <kloska@scienion.de>
Reply-To: kloska@scienion.de
Organization: Scienion AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz>
In-Reply-To: <20040607123839.GC11860@elf.ucw.cz>
X-MIMETrack: Itemize by SMTP Server on SrvW2k01/Scienion(Release 6.5.1|January 28, 2004) at
 07.06.2004 15:46:06,
	Serialize by Router on SrvW2k01/Scienion(Release 6.5.1|January 28, 2004) at
 07.06.2004 15:46:10,
	Serialize complete at 07.06.2004 15:46:10
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>My impression is that APM is slowly degenerating while ACPI is not
>>(yet ?) able to fill the gap. The suspend feature of ACPI is stated to
>>be dangerous and experimental and does not work for me at all.
> 
> 
> That sounds about right.
> 
> 
>>After all this bashing...
>>
>>Is there anyone out there who has the same experiences ?
>>
>>Is there a workaround ?
>>
>>Is it possible to somehow downgrade APM in the 2.6 kernel
>>to the 2.4.x state ?
>>
>>How could one debug this kind of missbehaviour ? Where do
>>I have to look for potential miss configurations of the system ?
>>
>>I'm really willing  to help the APM developers to track down this bug
>>but don't have a clue how to debug this kind stuff.
> 
> 
> What APM developers? There are none as far as I know.


   Hmmm ... So once again the Tooth Fairy and Santa Claus :-) ?

   At least a

   grep '<.*@' /usr/src/linux-2.6.6/arch/i386/kernel/apm.c | sed 's/.*<//' | sed 's/>.*//'

   gives me:

<snip>
Ulrich.Windl@rz.uni-regensburg.de
jtoth@princeton.edu
gaudet@arctic.org
cananian@alumni.princeton.edu
echter@informatik.uni-rostock.de
rankinc@bellsouth.net
cmiller@surfsouth.com
rgooch@atnf.csiro.au
rgooch@atnf.csiro.au
laslo@wodip.opole.pl
ross@soi.city.ac.uk
borislav@lix.polytechnique.fr
sitta@al.unipmn.it
teras@writeme.com
Walter.Hofmann@physik.stud.uni-erlangen.de
skawina@geocities.com
rusty@rustcorp.com.au
gis88564@cis.nctu.edu.tw
jima@hal.com
alan@lxorguk.ukuu.org.uk
jima@hal.com
andy_henroid@yahoo.com
pavel@suse.cz
andy_henroid@yahoo.com
zlatko@iskon.hr
crutcher+kernel@datastacks.com
arjanv@redhat.com
marc@mbsi.ca
alan@redhat.com
alan@redhat.com
jdthood@mail.com
chief@bandits.org
ast@domdv.de
rmk@arm.linux.org.uk
jdthood@mail.com
reese@isn.net
neale@lowendale.com.au
cmiller@surfsouth.com
chen@ctpa04.mit.edu
</snip>

This is pretty much for no one. And I guess you knew since you're on
the list yourself. But I think you're right when meaning
that there is not much of active maintenance anymore. Which at
least I find a little bit discouraging when looking of the state
of the ACPI support.


> 
> Try removing calls to device_* in apm.c. Better yet become APM
> developer.

   It seems like I'm on my way to do so (still reluctantly). As I stated
  in my previous mails I'm not born as a hardware/BIOS hacker (more the
  application C++/Java stuff) but I'm willing to learn. When I'm
  grown up I definitely want to be linux kernel hacker :-) ...

   Currently I ripped down the 2.6.6 kernel to almost nothing
  and add one module after the other checking for proper
  suspend/resume behavior....

   The most suspicious candidates on my list are currently  the
  USB-UHCI driver and the ALSA sound system, which is my #1 candidate
  since it has not been an integral part of the 2.4.x (x<=20) kernels.


  So if anybody out there could give me guidance on how the apm code
  might interact with the ALSA sound system it would be highly
  appreciated....

  Thanks

  Sebastian



> 							Pavel
