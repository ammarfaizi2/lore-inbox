Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTFBUW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTFBUW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:22:26 -0400
Received: from mail.somanetworks.com ([216.126.67.42]:59038 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S262336AbTFBUVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:21:19 -0400
Date: Mon, 2 Jun 2003 16:34:43 -0400
From: Georg Nikodym <georgn@somanetworks.com>
To: Jocelyn Mayer <jma@netgem.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
Message-Id: <20030602163443.2bd531fb.georgn@somanetworks.com>
In-Reply-To: <1054582582.4967.48.camel@jma1.dev.netgem.com>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.8.11claws175 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: #EE>^U0b8z^y>O0BZ>JJMGXyyxSP?<W-(g1&Yh;2p1'N6AeM]{Zfu(v>Uhe8ptGua4P}`QZ
 m%yb7CYwN^TiGQcP&mncyDrjAtLh7cB|m{$C,ww;yaYi*YvQllxb*vet
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.(EMDKhGNLx0L(Z"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.(EMDKhGNLx0L(Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 02 Jun 2003 21:36:22 +0200
Jocelyn Mayer <jma@netgem.com> wrote:

> ... at least for PPC targets.

As a datapoint, works fine for me with my x86 laptop:

(keller) 497$ cat /proc/bus/ieee1394/devices 
Node[00:1023]  GUID[0001d2000003a4ec]:
  Vendor ID: `Oxford Semiconductor Ltd.   ' [0x0001d2]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
    LSPD(0) MAX_REC(64) CYC_CLK_ACC(255)
  Unit Directory 0:
    Vendor/Model ID: Oxford Semiconductor Ltd.    [0001d2] / OXFORD IDE Device LUN 0  [42a258]
    Software Specifier ID: 00609e
    Software Version: 010483
    Driver: SBP2 Driver
    Length (in quads): 8
Node[01:1023]  GUID[474fc000075f5001]:
  Vendor ID: `Linux OHCI-1394' [0x000000]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(1) CMC(1) ISC(1) BMC(0) PMC(0) GEN(0)
    LSPD(2) MAX_REC(2048) CYC_CLK_ACC(0)
  Host Node Status:
    Host Driver     : ohci1394
    Nodes connected : 2
    Nodes active    : 2
    SelfIDs received: 2
    Irm ID          : [01:1023]
    BusMgr ID       : [63:1023]
    In Bus Reset    : no
    Root            : yes
    Cycle Master    : yes
    IRM             : yes
    Bus Manager     : no
You have new mail in /var/mail/georgn
(keller) 498$ cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IC35L120 Model: AVVA07-0         Rev:     
  Type:   Direct-Access                    ANSI SCSI revision: 06
(keller) 499$ cat /proc/scsi/sbp2_0/0 
Host scsi0             : SBP-2 IEEE-1394 (ohci1394)
Driver version         : $Rev: 906 $ James Goodwin <jamesg@filanet.com>

Module options         :
  max_speed            : S800
  max_sectors          : 255
  serialize_io         : no
  exclusive_login      : yes

Attached devices       : 
  [Channel: 00, Id: 00, Lun: 00]  Direct-Access     IC35L120 AVVA07-0        

(keller) 500$ uname -a
Linux keller 2.4.21-rc6-rmap15j #1 Sun Jun 1 18:43:25 EDT 2003 i686 GNU/Linux

--=.(EMDKhGNLx0L(Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+27TkoJNnikTddkMRAqFhAJ9ikxMWhYt4Cl+PxgL30N/+VceqTQCgmzCv
BABfSthPcsZc6ajxZuYQuRw=
=+GPF
-----END PGP SIGNATURE-----

--=.(EMDKhGNLx0L(Z--
