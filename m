Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVCBX4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVCBX4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVCBXx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:53:57 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:57050 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S261199AbVCBXv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:51:56 -0500
Date: Wed, 2 Mar 2005 18:51:40 -0500
From: "John L. Males" <jlmales@softhome.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jlmales@softhome.net
Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29
Message-Id: <20050302185140.6173e119.jlmales@softhome.net>
Reply-To: jlmales@softhome.net
Organization: Toronto, Ontario - Canada
X-Mailer: Sylpheed version 0.8.2-SrtRecipientSMTPAuthNDateSmartAcctSaveAllOpnNxtMsg (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="=_jive-17518-1109807508-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_jive-17518-1109807508-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Andrew/Kai,

> List:       linux-kernel
> Subject:    Re: Problems with SCSI tape rewind / verify on 2.4.29
> From:       Andrew Morton <akpm () osdl ! org>
> Date:       2005-03-02 22:17:11
> Message-ID: <20050302141711.00ec7147.akpm () osdl ! org>
> [Download message RAW]
> 
> Kai Makisara <Kai.Makisara@kolumbus.fi> wrote:
> >
> > f seek with tape is changed back to returning success, this would
> > enable correct tar --verify at the beginning of the tape. However,
> > I am not sure what happens if we are not at the beginning. I will
> > investigate this and suggest a long term fix to the tar people (a
> > fix that should be compatible with all Unix tape semantics I know)
> > and also suggest possible fixes to st (this may include automatic
> > writing of a filemark when BSF is used after writes).

Kai,

I have a second problem that is perhaps another case of kernel and tar
combined effect problem.  I have not had time to test with the 2.6.7
and 2.6.9 knoppix based kernels to see if same problem as >= 2.4.26
has.  Can you hold out about 3-4 days for me to do the test and report
the issue to Marcelo to screen first, Kai?  I have feeling what I
experienced in testing change to st.c Marcelo suggested that caused me
to try 2.4.26 again and fail on this new issue has some bearing on
tape positioning you want to check out.

> 
> Yes, please let's get a tar fix in the pipeline.
> 
> GNU tar must run on a lot of operating systems.  It's odd.
> 
> > If you think want to make st return success for seeks even if
> > nothing happens (as it did earlier), I don't have anything against
> > that. It would 

I think it is important if an error is enccountered a non-successful
return (code) is returned.  If an action is required that requires no
action as it is at the place/state/position being requested it is
reasonable to return a successful return (code). 

> > solve the practical problem several people have reported recently.
> > (My recommendation for the people seeing this problem is to do
> > verification separately with 'tar -d'.)

As aside, I have tried the tar -d option as well and it worked, but
was my understanding the --verify does a data readback compare of the
files in the tar, whereas the tar -d option only compares if files
names in tar to directory?  That to me means a big difference in
confidance the tar backup is ok, as I look to have readback verify to
increase confidance of backup success.

> 
> Yes, I think we need to grit our teeth and do this.  I'll stick a
> comment in there.


Regards,

John L. Males
Willowdale, Ontario
Canada
02 March 2005 (17:45 -) 18:51

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


--=_jive-17518-1109807508-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFCJlGTsrsjS27q9xYRAkRYAKCRtpXwjWJJgsQ/unax/fsctbXKYACg7P3e
hd0aoLh9YSMylwI13voBv3E=
=CAvv
-----END PGP SIGNATURE-----

--=_jive-17518-1109807508-0001-2--
