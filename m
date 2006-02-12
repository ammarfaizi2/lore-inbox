Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWBLXRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWBLXRj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 18:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWBLXRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 18:17:39 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:12959 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751042AbWBLXRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 18:17:38 -0500
Message-ID: <43EFC1FF.7030103@vilain.net>
Date: Mon, 13 Feb 2006 12:17:19 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: lkml@dervishd.net, peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner> <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114930.GC2750@DervishD> <43EC88B8.nailISDH1Q8XR@burner>
In-Reply-To: <43EC88B8.nailISDH1Q8XR@burner>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
>>    My system is clueless, too! If I write a CD before plugging my
>>USB storage device, my CD writer is on 0,0,0. If I plug my USB
>>storage device *before* doing any access, my cdwriter is on 1,0,0.
>>Pretty stable.
> You are referring to a conceptional problem in the Linux kernel.
> If you are unhappy with this, send a bug report to the related
> people.
> This does not belong to libscg.

Jörg,

Technically, you may have a point[*1*].

However, no matter how correct someone is, if they act like a complete
dork, they're not going to be listened to.

This is a shame, because you appear to have some good experience to
relate.  If only you could keep your social interaction problems in
check, you might be able to harbour and attract less hate, and perhaps
even get some of your suggestions implemented.

Until you do that, you will continue to find yourself getting caught out
on the details in the discussions while insulted people simply pick out
your mistakes; you cannot possibly fight the community and win.

Dave S. Miller gave an excellent talk on this subject at Linux.conf.au;
when the video is available I'll send you a link to it.

Sam.

*1*  Linux doesn't use the Solaris style of a connection-oriented /sys
that /dev is all symlinks to, that scandevices et al update.  This leads
to a more stable /dev filesystem, such that even adding controllers in
lower numbered slots will not reorder the devices, as the /dev
filesystem state remembers them.

This was a no-brainer design decision, as the hardware platform was
under strict control, and the builds more regulated.  Linux has never
really seen this type of integration fascism available that this kind of
approach requires, and so this kind of solution is inappropriate.

However, Solaris is not immune to the root problem being discussed, for
connection types that give dynamically assigned IDs (like USB) rather
than statically defined (like SCSI).  You simply might not be able to
recognise the device after a system change.
