Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbQKVAPR>; Tue, 21 Nov 2000 19:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbQKVAPI>; Tue, 21 Nov 2000 19:15:08 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:20741 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S129777AbQKVAO7>; Tue, 21 Nov 2000 19:14:59 -0500
Date: Wed, 22 Nov 2000 00:43:46 +0100
From: Kurt Garloff <garloff@suse.de>
To: Malte Cornils <malte@cornils.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: tmscsim driver on test11-pre7 stops working when starting X
Message-ID: <20001122004346.O16278@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Malte Cornils <malte@cornils.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3A188657.AD2C7BFE@cornils.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="OmL7C/BU0IhhC9Of"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A188657.AD2C7BFE@cornils.net>; from malte@cornils.net on Mon, Nov 20, 2000 at 03:03:03AM +0100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OmL7C/BU0IhhC9Of
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2000 at 03:03:03AM +0100, Malte Cornils wrote:
> my Dawicontrol 2974 SCSI-adapter fails with kernel 2.4.0-test10=20
> with pre-11 and reiserfs for kernel test-10 patched in:
>=20
> --
> Nov 20 01:30:23 wh36-b407 kernel: scsi : aborting command due to timeout =
: pid 0, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 08 c0 6c 00 00 f8 00=
 =20
> Nov 20 01:30:23 wh36-b407 kernel: DC390: Abort command (pid 0, DCB c12c11=
c0, SRB 00000000)
> Nov 20 01:30:23 wh36-b407 kernel: DC390: Status of last IRQ (DMA/SC/Int/I=
RQ): 0890cc20
> Nov 20 01:30:23 wh36-b407 kernel: DC390: Register dump: SCSI block:
> Nov 20 01:30:23 wh36-b407 kernel: DC390: XferCnt  Cmd Stat IntS IRQS FFIS=
 Ctl1 Ctl2 Ctl3 Ctl4
> Nov 20 01:30:23 wh36-b407 kernel: DC390:  000000   44   10   cc   00   80=
   17   48   18   04
> Nov 20 01:30:23 wh36-b407 kernel: DC390: Register dump: DMA engine:
> Nov 20 01:30:23 wh36-b407 kernel: DC390: Cmd   STrCnt    SBusA    WrkBC  =
  WrkAC Stat SBusCtrl
> Nov 20 01:30:23 wh36-b407 kernel: DC390:  80 00001000 051a4000 00000000 0=
51a5000   00 03080000
> Nov 20 01:30:23 wh36-b407 kernel: DC390: Register dump: PCI Status: 0200
> Nov 20 01:30:23 wh36-b407 kernel: DC390: In case of driver trouble read l=
inux/drivers/scsi/README.tmscsim
> Nov 20 01:30:23 wh36-b407 kernel: DC390: Aborted pid 0 with status 0

pid 0: So, already the device scan fails?
I'll have to look up the register dump to analyze it. Would you test the
patch I sent you on top of 2.0e5, please?

> This happened on the second bootup with the new kernel, when kdm
> was starting Xfree 4.0.1 from Debian woody.
> Nov 20 01:29:34 wh36-b407 kernel: Bad boy: tmscsim (at 0xc02bf732) called=
 us without a dev_id!

Fixed in 2.0eX, BTW.

> I noted there's a new version of the driver on the maintainer's (Kurt
> Garloff) homepage, but last time I tested it and reported an oops with
> 2.4.test-something he didn't reply at all (that's not an offense, it's
> understandable with the amount of work he's doing for KDE2 etc).

I tend to answer mails, where I know a solution very quickly, but tend to
not send messages like "Thanks I got your mail, I'll look into it!"
Actually, when I got some time to do some work, I look for yet unanswered
mails.

> So should I
> a) try with his patch again; my oops report for that is attached below
> b) wait you can make of this bugreport
> c) provide any further info/testing?

Test the patch on 2.0e5 I sent you, please.

> BTW, 2.2.17 with the stock tmscsim works fine everytime; with that kernel
> (and no other changes) the system is excessively stable :)

That's at least something!

> CU, Yours Malte #8-)
>=20
> PS: Please cc me, I'm usually watching the lists I report bugs to, but LK=
ML
> is a bit... excessive; I'll monitor the list from time to time, but can't
> guarantee timely responses...

Nor can I. Actually, messages concerning drivers I maintain are sorted by
procmailrc to a different folder :-)

> The next boot, while in the fsck-Phase for the SCSI drive (SysRq
> didn't work *that* well obviously :)) I got the oops. There were
> some lines scrolling by which I unfortunately couldn't write down
> fast enough, but I did copy the oops:
>=20
> Oops: 0000

Should be fixed in 2.0e5 and later.

> Also, the oops occured when I was sharing interrupts (but this is
> PCI, so there should be no problems, right?).

That's correct only if level triggered IRQs are used.

> I just fear that Linus might avoid large patches for the now
> imminent 2.4... :-?

The 2.0d driver does not work correctly with 2.4, and I'm trying to make
sure 2.0f will be perfect. I don't see why Linus should refuse to accept
a patch.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--OmL7C/BU0IhhC9Of
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6GwixxmLh6hyYd04RAtnTAJsFWuNUheFt7az8XMC7r6KWqR2bDgCgnGp8
qHluoO+a9BQiMNwM1zIg6nw=
=csF8
-----END PGP SIGNATURE-----

--OmL7C/BU0IhhC9Of--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
