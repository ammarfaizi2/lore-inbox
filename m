Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSHIOTZ>; Fri, 9 Aug 2002 10:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSHIOTZ>; Fri, 9 Aug 2002 10:19:25 -0400
Received: from handhelds.org ([192.58.209.91]:55736 "HELO handhelds.org")
	by vger.kernel.org with SMTP id <S312619AbSHIOTX>;
	Fri, 9 Aug 2002 10:19:23 -0400
From: George France <france@handhelds.org>
To: "Martin Brulisauer" <martin@bruli.net>, o.pitzeier@uptime.at,
       ghoz@sympatico.ca, Jay.Estabrook@compaq.com,
       pollard@tomcat.admin.navo.hpc.mil
Subject: Re: kbuild 2.5.26 - arch/alpha
Date: Fri, 9 Aug 2002 10:23:06 -0400
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, "'Bryce'" <bryce@redhat.com>,
       "Christopher C. Chimelis" <chris@debian.org>,
       Harry <Harry.Heinisch@hp.com>, Jeff.Wiedemeier@hp.com,
       Peter Petrakis <voodoo@alphadriven.org>,
       Rich Payne <rdp@talisman.alphalinux.org>,
       "Christopher C. Chimelis" <chris@debian.org>
References: <002b01c23279$84be70a0$1211a8c0@pitzeier.priv.at> <3D53AEF8.16231.E49799D@localhost>
In-Reply-To: <3D53AEF8.16231.E49799D@localhost>
MIME-Version: 1.0
Message-Id: <02080910230605.04020@shadowfax.middleearth>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

I am glad to have received your e-mail.  I was just thinking about
you.  For a quick update, as I am attempting to get demos out the
door for LWE:

Bryce has convinced me to setup a daily diary on advantgo.

   http://www.advogato.org/person/France

which I plan on updating this afternoon.  In short for me on alpha this
week:

Monday: I worked on the usb-uhci.c driver which has a few
               32 bitisms.  I will not have time to submit a tested
               patch until after LWE. The problem appears to be

                   unsigned int io_addr = pci_resource_start()

               and possibly

                   unsigned int io_size = pci_resource_len()

              putting a 64bit address into a 32bit slot just does not
              work very well. :-)  Even after changes the 'int' to 'long',
              the USB device worked extremely well, but upon inserting or
              removing a USB device, the SCSI controller on my system
              hangs for about 30 secs while it resets due to receiving
              an invalid instruction.  I suspect that there is corruption
              of some kind on the PCI bus, but I do not have time this 
             week to track this down.

Tuesday: My Binutils patch was accepted for adding
               -mev67, -mev68, -m21264a and -m21264b
               Chatted with Bryce on several Alpha related issues.

Wed: Meet with Jay, Jeff, John and Harry in Nashua.
         Jeff has 2.5.x (x=29 IIRC) working with smp and non smp systems.
         after some testing the patches should make it to the kernel soon.
         I pushed out updates for RH7.2 (Alpha) for  gcc, util-linux, glibc
         and openssl.
         I worked on the RSS patches for the autobuild system.

Thur: I chatted (e-mail) with Peter Petrakis today.  He would like me to upgrade
         the system which hosts alphanews.net and linuxalpha.org to use RH7.2
         I hope to have time on Friday (today, yikes!), before I leave for LWE.

As for gcc 3.1 in the kernel, most Alpha kernel hackers use egcs or 2.95. 
Personally I tend to use 2.95 for my kernels.

I have UNH students that build several complete toolchains everyday
for alpha including 2.95.x, 3.0.x, 3.1.x and gcc-head.  By complete tool
chain I mean binutils, gcc, gdb, glibc and all the support programs.

   http://handhelds.org/projects/toolchain/autobuild/build-results.php3

I am certain that they would like to chat with you in great detail about
toolchain issues related to the Alpha architecture.

I agree that communications in regard to Alpha could and should be better.
We should probably setup a wiki or webpage to help keep track of  Alpha
issues or maybe just use one of the existing alpha mailing lists or I could
setup something on alpha.crl.dec.com next week.

I hope this helps.

Best Regards,


--George

On Friday 09 August 2002 06:00, Martin Brulisauer wrote:
> On 23 Jul 2002, at 18:29, George France wrote:
> > On Tuesday 23 July 2002 14:48, Oliver Pitzeier wrote:
> > > [ ... ]
> > >
> > > > You have made me aware that we have unintentionally created a
> > > > private sort of club.  I apologize. This will have to be corrected.
> > >
> > > That's not what I expected to read...
> > > I think that this "private club" is not wrong at all... It just would
> > > be nicer if there would be some kind of batch every week where all
> > > alpha users/developers get a mail...
> >
> > I agree. We should send a weekly e-mail with the current status.
>
> I did not see any news on the alpha/linux topic in lkml lately.
>
> What is the way to keep in touch with the "private club" to help/
> assist in getting further to a running 2.5.x kernel on alpha? I
> am still on 2.4.18 on my test system.
>
> Did anybody use gcc-3.0.x or gcc-3.1? With gcc-3.0.4 I
> successfully built 2.4.18 but some applications don't run
> correctly (eg. MySQL -> Parser). Is the kernel compilable
> with gcc-3.1? Today I am using gcc-2.95.3 and I think is
> ok; better than egcs (generates less unaligned traps at
> runtime without changing the source).
>


