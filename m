Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVCBVRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVCBVRI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVCBVRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:17:08 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:8589 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S262467AbVCBVPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:15:19 -0500
Date: Wed, 2 Mar 2005 16:15:07 -0500
From: "John L. Males" <jlmales@softhome.net>
To: marcelo.tosatti@cyclades.com
Cc: jlmales@softhome.net, gene.heskett@verizon.net,
       linux-kernel@vger.kernel.org
Subject: Re: Re[03]: Problems with SCSI tape rewind / verify on 2.4.29
Message-Id: <20050302161507.2a67385c.jlmales@softhome.net>
In-Reply-To: <20050302154626.65bc03e5.jlmales@softhome.net>
References: <E7F85A1B5FF8D44C8A1AF6885BC9A0E472B886@ratbert.vale-housing.co.uk>
	<20050302120332.GA27882@logos.cnet>
	<200503021208.51480.gene.heskett@verizon.net>
	<20050302143440.GA2543@logos.cnet>
	<20050302154626.65bc03e5.jlmales@softhome.net>
Reply-To: jlmales@softhome.net
Organization: Toronto, Ontario - Canada
X-Mailer: Sylpheed version 0.8.2-SrtRecipientSMTPAuthNDateSmartAcctSaveAllOpnNxtMsg (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="=_jive-26895-1109798118-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_jive-26895-1109798118-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Marcelo,

Sorry gents, seems the LKML used to handel the RE numbering in long
past when I last mailed to LKML, bit not now, so resending this eMail
to ensure goes back to orignal thread so all the eMail discussion is
in one eMail thread.

My applogies if this caused confusion on the LKML.


Regards,

John L. Males
Willowdale, Ontario
Canada
02 March 2005 (16:06 -) 16:15


********** Reply Seperator **********

On (Wed) 2005-03-02 15:46:26 -0500 
John L. Males wrote in Message-ID:
20050302154626.65bc03e5.jlmales@softhome.net

To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
From: John L. Males <jlmales@softhome.net>
Subject: Re[03]: Problems with SCSI tape rewind / verify on 2.4.29
Date: Wed, 2 Mar 2005 15:46:26 -0500

> Hi Marcello,
> 
> 
> ********** Reply Seperator **********
> 
> On (Wed) 2005-03-02 11:34:41 -0300 
> Marcelo Tosatti wrote in Message-ID:
> 20050302143440.GA2543@logos.cnet
> 
> To: Gene Heskett <gene.heskett@verizon.net>
> From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29
> Date: Wed, 2 Mar 2005 11:34:41 -0300
> 
> > 
> > n Wed, Mar 02, 2005 at 12:08:51PM -0500, Gene Heskett wrote:
> > > On Wednesday 02 March 2005 07:03, Marcelo Tosatti wrote:
> > > >On Wed, Mar 02, 2005 at 11:15:42AM -0000, Mark Yeatman wrote:
> > > >> Hi
> > > >>
> > > >> Never had to log a bug before, hope this is correctly done.
> > > >>
> > > >> Thanks
> > > >>
> > > >> Mark
> > > >>
> > > >> Detail....
> > > >>
> > > >> [1.] One line summary of the problem:
> > > >> SCSI tape drive is refusing to rewind after backup to allow
> > > >verify> and causing illegal seek error
> 
> In my experiences with this problem that I am sure is exactly the
> same issue, the tape in fact does rewind after creating the tar to
> then perfore the --verify option.  The illegal see error seems to
> arise after the rewind or more correctly bsf commands may be being
> used (but not confirmed this yet, another test I need to do in few
> days).  For sure the tape is positionted back.  I know as I have
> also done this test with larger directories and know and have heard
> the tape take long time to naturally get back to the start of tar
> file to be able to perform the --verify option.  That said I am
> using a DLT drive. Perhpas with different drivers or tape drivers
> this issue may have variations on theme and behaviour with net
> result the same error message and/or root cause.
> 
> > > >>
> > > >> [2.] Full description of the problem/report:
> > > >> On backup the tape drive is reporting the following error and
> > > >> failing it's backups.
> > > >>
> > > >> tar: /dev/st0: Warning: Cannot seek: Illegal seek
> > > >>
> > > >> I have traced this back to failing at an upgrade of the
> > > >kernel to> 2.4.29 on Feb 8th. The backups have not worked
> > > >since. Replacement> Drives have been tried and cables to no
> > > >avail. I noticed in the> the changelog that a patch by Solar
> > > >Designer to the Scsi tape> return code had been made.
> 
> Last kernel to work correctly in 2.4 branch was 2.4.26.  Kernel
> versions 2.4.27, 2.4.28 and 2.4.29 all fail based on my experience
> with DLT SCSI based tape.
> 
> > > >
> > > >v2.6 also contains the same problem BTW.
> > > >
> > > >Try this:
> > > >
> > > >--- a/drivers/scsi/st.c.orig 2005-03-02 09:02:13.637158144
> > > >-0300+++ b/drivers/scsi/st.c 2005-03-02 09:02:20.208159200
> > > >-0300@@ -3778,7 +3778,6 @@
> > > >  read:  st_read,
> > > >  write:  st_write,
> > > >  ioctl:  st_ioctl,
> > > >- llseek:  no_llseek,
> > > >  open:  st_open,
> > > >  flush:  st_flush,
> > > >  release: st_release,
> > > >-
> > > 
> > > Interesting Marcelo.  How long has this been true in 2.6?
> 
> In the 2.6 tree the tar --verify works with 2.6.7, but fails with
> 2.6.9. I am unable to test 2.6.8, but based on research of the code
> changes of 2.6.8 compared to the changes made in 2.4.27 re llseek I
> would expect 2.6.8 to fail as well with my DLT SCSI tape. 
> 
> > 
> > Actually I just checked and it seems v2.6 is not using
> > "no_llseek".
> > 
> > However John L. Males reports the same problem with v2.6 - John,
> > care to retest with v2.6.10 ?
> 
> My ability to test a 2.6.x kernel is limited to what 2.6.x kernel I
> can find on a livecd.  The 2.6.7 and 2.6.9 kernel tests I conducted
> were using Knoppix 3.6 and 3.7.  I do not have means at this time,
> nor time, to build up a dedicated drive to test 2.6.x kernels.  If
> someone knows of or can build a 2.6.10 kernel on a live CD I will be
> happy to do the test.  That said, I looked at the patch for 2.6.10
> and seems alot of changes were made to st.c in 2.6.10.  I did not
> see, but could of missed in looking, any lseek related change in
> 2.6.10.  Given how it seems the test I ran with the change in st.c
> Marcell suggested what is the expected thought on this issue with
> 2.6.10?  I am just asking from curiousity.  Again, if someone can
> tell me of a live cd or can easly make a live cd with the 2.6.10
> kernel I can test this issue wiht 2.6.10.  Perhaps there is someone
> else with a DLT/SCSI tape driver that could test this tar --verify
> issue on 2.6.10?
> 
> > 
> > > I thought I had an amanda problem, and eventually went to
> > > virtual tapes on disk, largely because of this.  However, I have
> > > to say it is working better than tapes ever did here.  Unforch,
> > > that 200GB disk is certainly a single point of failure I don't
> > > relish thinking about...
> > 
> > :)
> 
> 
> Regards,
> 
> John L. Males
> Willowdale, Ontario
> Canada
> 02 March 2005 (15:00 -) 15:46
> 
> 
> ==================================================================
> 
> 
> "Boooomer ... Boom Boom, how are you Boom Boom"
> "Meoaaaawwwww, meoaaaaaawwww" as Boomer loudly announces
>      intent Boomer is coming for attention
> Loved to kneed arm and lick arm with Boomers very large
>      tongue
> Able to catch, or at least hit, almost any object in flight
>      withing reach of front paws
> Boomer 1985 (Born), Adopted 04 September 1991
> 04 September 1991 - 08 February 2000 18:50
> 
> "How are you Mr. Sylvester?"
> "... Grunt Grunt" ... quick licks of nose
> Rolls over for pet and stomac rub when Dad arrives home
>      and grunting
> Runs back and forth from study, tilts head as glowing green
>      eyes stare for "attention please", grunts and meows,
>      repeats run, tilt head and stare few times for good
>      measure, grunts and meows
> Lays on floor just outside study to guard Dad
> Loved to groom Miss Mahogany, and let Mahogany cuddle beside
> Sylvester 1989 (estimated Born)
> Found in building mail area noon hour 09 Feburary 1992
> 09 February 1992 - 19 January 2003 23:25
> 
> "Hello Miss Chicago 'White Sox', how are you 'Chico'?"
> "Grunt" (thank you) ... as put out food for Chicago
> "MEEEEEOOOOWWWW" So loud the world stops
> A very determined Miss "White Sox"
> AKA "Chico" ... Cheryl Crawford used as nickname
> Loved to chase kibble slid down hall floor,
>      bat about and then eat
> Loved to hook paw in dish to toss out a single kibble
>      at time, dart at as moved, then eat ... "Crunches"
> Chicago "White Sox", "Chico" August 1989 (born),
>      adopted 04 February 1991
> 05 October 2004 06:52 Quite "Grunts" ....
>                       as lay Chicago on bed for last time
> 04 February 1991 - 05 October 2004 07:32
> 
> 


==================================================================


"Boooomer ... Boom Boom, how are you Boom Boom"
"Meoaaaawwwww, meoaaaaaawwww" as Boomer loudly announces
     intent Boomer is coming for attention
Loved to kneed arm and lick arm with Boomers very large
     tongue
Able to catch, or at least hit, almost any object in flight
     withing reach of front paws
Boomer 1985 (Born), Adopted 04 September 1991
04 September 1991 - 08 February 2000 18:50

"How are you Mr. Sylvester?"
"... Grunt Grunt" ... quick licks of nose
Rolls over for pet and stomac rub when Dad arrives home
     and grunting
Runs back and forth from study, tilts head as glowing green
     eyes stare for "attention please", grunts and meows,
     repeats run, tilt head and stare few times for good
     measure, grunts and meows
Lays on floor just outside study to guard Dad
Loved to groom Miss Mahogany, and let Mahogany cuddle beside
Sylvester 1989 (estimated Born)
Found in building mail area noon hour 09 Feburary 1992
09 February 1992 - 19 January 2003 23:25

"Hello Miss Chicago 'White Sox', how are you 'Chico'?"
"Grunt" (thank you) ... as put out food for Chicago
"MEEEEEOOOOWWWW" So loud the world stops
A very determined Miss "White Sox"
AKA "Chico" ... Cheryl Crawford used as nickname
Loved to chase kibble slid down hall floor,
     bat about and then eat
Loved to hook paw in dish to toss out a single kibble
     at time, dart at as moved, then eat ... "Crunches"
Chicago "White Sox", "Chico" August 1989 (born),
     adopted 04 February 1991
05 October 2004 06:52 Quite "Grunts" ....
                      as lay Chicago on bed for last time
04 February 1991 - 05 October 2004 07:32


--=_jive-26895-1109798118-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFCJizlsrsjS27q9xYRAonBAJ45IbcbB1qI1SeFnb5W8xHpS0uqpwCZAfbq
KNShLxOZLdi4UAC6Trd40T8=
=9BYW
-----END PGP SIGNATURE-----

--=_jive-26895-1109798118-0001-2--
