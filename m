Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273705AbRIXABY>; Sun, 23 Sep 2001 20:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273716AbRIXABS>; Sun, 23 Sep 2001 20:01:18 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:18386 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S273705AbRIXAAw>;
	Sun, 23 Sep 2001 20:00:52 -0400
From: "John L. Males" <jlmales@softhome.net>
Organization: Toronto, Ontario, Canada
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 23 Sep 2001 20:00:53 -0500
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_jive-14546-1001289598-0001-2"
Subject: Re[05]: Linux Kernel 2.2.20-pre10 Initial Impressions
Reply-to: jlmales@softhome.net
CC: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
Message-ID: <3BAE3F75.665.75F16A@localhost>
In-Reply-To: <3BAC8E1C.2201.524EE2@localhost> from "John L. Males" at Sep 22, 2001 01:11:56 PM
In-Reply-To: <E15ks0U-0003xB-00@the-village.bc.nu>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_jive-14546-1001289598-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-description: Mail message body

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Alan,

I have completed some testing.  Some as I am not sure what other
testing I need to do as will become evident below.  I have not copied
in Andrea Arcangeli.  Based on the results it would be my (limited
Linux Kernel knowledge) opinion whatever I am observing is not likely
VM related.

The summary of the results are as follows:


Test Case One:
****************

Steps used:

- - Boot System
- - Log onto non-root user id.
- - "startx" (KDE desktop started)
(applications prestart from last log off include kppp, kpppload,
xosview, gnome terminal, khrono, 3 kfm's)
- - Start Netscape 4.78 from desktop ICON
- - Click the pull down arrow on far right side of the "Go To:" (AKA
URL line) of Netscape 4.78.

Results:

For Kernel 2.2.19OWL, 2.2.20-pre10, 2.4.9-ac10

All were instant response from Netscape.  Did the test for each
kernel twice; and yes that means each of the 6 tests were done from a
new boot of the PC.

This is the expected result, but until I did this test I was not
aware of any instant Netscape response to this action.  My "usual"
personal sequence of starting things was different, but traditional
as will be noted later.  I came up with this test based on some
non-browser experiences the latter part of this week.


Test Case Two:
*****************

Steps used:

- - Boot System
- - Log onto non-root user id.
- - "startx" (KDE desktop started)
(applications prestart from last log off include kppp, kpppload,
xosview, gnome terminal, khrono, 3 kfm's)
- - Had kppp "connect" to my ISP (dial up model 56KB, really 49,300
most of time, some connects 48,000, note kppp is configured to start
up ntpdate to sync with some time servers.)
- - Start Netscape 4.78 from desktop ICON
- - Click the pull down arrow on far right side of the "Go To:" (AKA
URL line) of Netscape 4.78.

Results:

For Kernel 2.2.19OWL, 2.2.20-pre10, 2.4.9-ac10

All times were 2 minutes 3 seconds to get the URL list that appears
when one clicks the noted button.  Did the test for each kernel
twice; and yes that means each of the 6 tests were done from a new
boot of the PC.

This is sort of the expected results, but until I did this test I was
not aware of how long the waint was in absolute terms.  My "usual"
personal sequence of starting things was different, but traditional
as will be noted later.  I came up with this test as I wanted to see
if the IPChains (2.2 kernels) or IPTables (2.4 kernel) was having an
effect on the delays I experienced.

Although I had never know how long it took for this URL list to
appear, my memory from my expereinces (have many as been happening
for long time)  was that with the 2.2.20-pre10 kernel things were
really much much longer.  Clearly from the tests I have done that is
not the case.  This test is not exactly how I usually start things
up.  Normally I have kppp start the IPChains script, then I start
Netscape.  This test clearly shows some relationship to my ppp0
connection being established and how long Netscape took to respond to
viewing a URL list.  Note we are not actually selecting a site to go
to, hence why test one was done and the very big surprize discovering
there was no delay in the action.  the test is just to click the list
button to see the list, no more than that.


Test Case Three:
*******************

Steps used:

- - After the second test with Kernel 2.4.9-ac10 of Test Case Two
- - kppp is still up and connected to ISP from Test Case Two
- - Closed Netscape completely.
- - Start Netscape 4.78 from desktop ICON
- - Click the pull down arrow on far right side of the "Go To:" (AKA
URL line) of Netscape 4.78.

Results:

For Kernel 2.4.9-ac10 as only Kernel did this test with:

For the two times this test case was also done, still a delay of 2
minutes 3 seconds from the time clicked the button until the URLs
appeared.

A special note for the second test done in this test case.  After the
first time did test for this test case, did an e2fsck and mount for a
mount point for HDA7.  The other mount points are all SCSI and
started at boot time.  The HDA device is not being auto mounted
mostly to allow me to work around the various problems with booting,
related lilo, but also exist with grub.  Again I decided on this
varient of the test as I do in fact start the system at times without
the HDA drive mounted or the IDE interface disabled when I need to do
lilo activities.


Test Case Four:
******************

Steps used:

- - After the second test with Kernel 2.4.9-ac10 of Test Case three
- - kppp is still up and connected to ISP from Test Case Two
- - Closed Netscape completely.
- - Started my IPTables based script that was also set to do a
"iptables -Lv" at end to see if that altered the time of the delay as
this would often match a suitation I have had in past few weeks on my
Linux system.
- - Start Netscape 4.78 from desktop ICON
- - Click the pull down arrow on far right side of the "Go To:" (AKA
URL line) of Netscape 4.78.

Results:

For Kernel 2.4.9-ac10 as only Kernel did this test with:

For the one time I did this test case, a delay of 2 minutes 19
seconds from the time clicked the button until the URLs appeared.


Test Case Five:
*****************

Steps used:

- - Boot System
- - Log onto non-root user id.
- - "startx" (KDE desktop started)
(applications prestart from last log off include kppp, kpppload,
xosview, gnome terminal, khrono, 3 kfm's)
- - Had kppp "connect" to my ISP (dial up model 56KB, really 49,300
most of time, some connects 48,000, note kppp is configured to start
up ntpdate to sync with some time servers.)
- - Started my IPChains based script that was also set to do a
"ipchains -L" at end to see if that altered the time of the delay as
this would often match a suitation I have had in past few weeks on my
Linux system.
- - Start Netscape 4.78 from desktop ICON
- - Click the pull down arrow on far right side of the "Go To:" (AKA
URL line) of Netscape 4.78.

Results:

For Kernel 2.2.19OWL only was this test done.  First time the delay
was 2 minutes 3 seconds, the second time it was 2 minutes 15 seconds.


Other Comments
*******************

All the kernels were complied using the same gcc compiler supplied
with SuSE 6.4.  The SuSE 6.4 I am using is up to date as of about
April/2001 as far as security fixes and like.  It is still using KDE
1.1.2, and XFree 3.3.6.  And yes the necessary elements to meet the
requirements of the 2.4 kernel are in place.  I managed to work the
SuSE 7.2 versions of those tools into the SuSE 6.4 system with some
nurturing :).  Other than that it is basically a SuSE 6.4 system
witth the odd application at a much higher level than supplied with
SuSE, but these are either console or X based apps.  Obviously no KDE
2 apps on this system.

Also of interesting note, during the time delay experienced there was
not much, if any CPU activity, so the delay does not seem to be
"processing" related.  For all intents and purposes I could not
observe any internet activity.  That is not to say there was none,
but not really observable.

In terms of the two 2.2 Kernels, the 2.2.20-pre-10 kernel was build
using the config of the 2.2.19 kernel via oldconfig.  The only
difference was when running oldconfig it asked about one item that
was not in the 2.2.19 kernel.  My reply was to make the module, even
though I had no use for the module.

The 2.2.19 Kernel is the base kernel from kernel.org plus the
Openwall patch:

http://www.openwall.com/linux/linux-2.2.19-ow1.tar.gz

Of course there was no Openwall patch made to the 2.2.20-pre10
kernel.

I have attached a screen image of the URL history list that was the
subject of this test to give a better understanding of what was being
selected to display.

This is not the only area where there are unexpected delays.  I am
just most familar with this one as it is the one I happen to do
almost every day.  Now although I am sure there were shorter and
different delays, I cannot duplicate it at moment the shorter ones
for the activity I do every day.  I will keep my wits about me to
better observe and see if I can identify what may be related to the
amount of time in a delay.

As for the impact of this observation for the 2.2.20-pre10 Kernel, I
am in no position to really say given my very lack of familarity with
the process, not to mention the kernel itself.  As a QA/Testing
person I can say that from what I have experienced in the past, and
see with the 2.2.20-pre10 kernel on the issue I am experiencing there
is likey no change.  At this point I would not be able to say if the
matter has some kernel element of impact or not.

It is possible I may have omitted some important point(s) in this
eMail note, or even omitted in my testing.  If so feel free to
comment.  I will be busy over the wekk and suggestion has it I will
need to work next weekend.  Be that the case, please be patient if I
am very slow in replying to any additional information or
clarification that may be required.


Regards,

John L. Males
Willowdale, Ontario
Canada
23 September 2001 20:00
mailto:jlmales@softhome.net


Subject:        	Re: Re[03]: Linux Kernel 2.2.20-pre10 Initial
Impressions
To:             	jlmales@softhome.net
Date sent:      	Sat, 22 Sep 2001 20:00:06 +0100 (BST)
Copies to:      	alan@lxorguk.ukuu.org.uk (Alan Cox),
linux-kernel@vger.kernel.org
From:           	Alan Cox <alan@lxorguk.ukuu.org.uk>

> > Understood, but I actually took my 2.2.19 .config and ran "make
> > oldconfig", then "make xconfig" making no changes, just saved it 
> 
> Excellent. That makes the data so much more valuable
> 
> > I am likely to do the benchmark tonight to get hard numbers on
> > the difference I sense.  I am a QA/Testing Specialist, so I am
> > all to aware of the importance of keeping the variables all the
> > same.  My initial background was with assembler back in the real
> > core
> > memory/keypunch days where I disassembled and heavily modified
> > the OS, compiler, assembler, system utilities and wrote a new way
> > to load the OS, compilers, etc from scratch to a new disk.  Ony
> > advising you so you have a sense of my mindset and level of
> > understanding.  Not current with intimate x86 details or
> > assembler, but will someday now that "falt" memory is back! :))
> > 
> > I will let you know what I find.  If in meantime you feel there
> > are other things needed or for me to check please let me know and
> > I will be most happy to assist.
> 
> I look forward to the results. Can you cc Andrea Arcangeli on them
> if they look VM related as Andrea is the 2.2.19 VM person (and now
> the 2.4.10pre one)


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use 
<http://www.pgp.com>

iQA/AwUBO66FquAqzTDdanI2EQLaBACg0SD0omLkTiCHBmfZMXXXCKsdjVcAoOi7
dYuaMbqUOnO1/1Fr108/ttbf
=dRDV
-----END PGP SIGNATURE-----



"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 - February/2000

--=_jive-14546-1001289598-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-disposition: inline
Content-description: Attachment information.

The following section of this message contains a file attachment
prepared for transmission using the Internet MIME message format.
If you are using Pegasus Mail, or any another MIME-compliant system,
you should be able to save it or view it from within your mailer.
If you cannot, please ask your system administrator for assistance.

   ---- File information -----------
     File:  ns478.png
     Date:  23 Sep 2001, 13:40
     Size:  12884 bytes.
     Type:  Unknown

--=_jive-14546-1001289598-0001-2
Content-Type: application/octet-stream; name="ns478.png"; type=Unknown
Content-Transfer-Encoding: base64
Content-disposition: attachment; filename="ns478.png"

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

--=_jive-14546-1001289598-0001-2--
