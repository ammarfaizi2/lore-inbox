Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbSLCLQQ>; Tue, 3 Dec 2002 06:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbSLCLQQ>; Tue, 3 Dec 2002 06:16:16 -0500
Received: from itaqui.terra.com.br ([200.176.3.19]:20127 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP
	id <S266233AbSLCLQO>; Tue, 3 Dec 2002 06:16:14 -0500
Date: Tue, 3 Dec 2002 09:23:33 -0200
From: Lucio Maciel <abslucio@terra.com.br>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org,
       "rusty's trivial patch monkey" <trivial@rustcorp.com.au>
Subject: [TRIVIAL PATCH 2.5] Uninitialised timer in matroxfb_DAC1064 [Was] Re: What does that mean (2.5.50)?
Message-Id: <20021203092333.17baff0d.abslucio@terra.com.br>
In-Reply-To: <20021202213335.GB28863@ulima.unil.ch>
References: <20021202212421.GA28863@ulima.unil.ch>
	<20021202213335.GB28863@ulima.unil.ch>
Organization: absoluta
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__3_Dec_2002_09:23:33_-0200_085cc730"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__3_Dec_2002_09:23:33_-0200_085cc730
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit


Fix an Uninitialised timer in matroxfb_DAC1064.c

best regards
On Mon, 2 Dec 2002 22:33:35 +0100
Gregoire Favre <greg@ulima.unil.ch> wrote:

> On Mon, Dec 02, 2002 at 10:24:21PM +0100, Gregoire Favre wrote:
> 
> > matroxfb: framebuffer at 0xDC000000, mapped to 0xe0805000, size 33554432
> > Uninitialised timer!
> > This is just a warning.  Your computer is OK
> > function=0xc02a654c, data=0x0
> > Call Trace:
> >  [<c0123e7f>] check_timer_failed+0x63/0x65
> >  [<c02a654c>] cursor_timer_handler+0x0/0x3c
> >  [<c0123ec0>] add_timer+0x3f/0xa1
> >  [<c02a68fa>] fbcon_startup+0x4b/0x4d
> >  [<c023c400>] take_over_console+0x29/0x1c8
> >  [<c02a5be8>] register_framebuffer+0xe9/0x16d
> >  [<c02ad111>] initMatrox2+0x849/0xaba
> >  [<c02ad810>] matroxfb_probe+0x286/0x2da
> >  [<c021e80a>] pci_device_probe+0x5e/0x6c
> >  [<c0227746>] bus_match+0x45/0x7d
> >  [<c0227847>] driver_attach+0x51/0x69
> >  [<c0227b13>] bus_add_driver+0xa7/0xcd
> >  [<c0227ef5>] driver_register+0x2f/0x33
> >  [<c01703c5>] create_proc_entry+0x88/0xbc
> >  [<c021e922>] pci_register_driver+0x47/0x57
> >  [<c010506e>] init+0x3d/0x15a
> >  [<c0105031>] init+0x0/0x15a
> >  [<c0107079>] kernel_thread_helper+0x5/0xb
> > 
> > Console: switching to colour frame buffer device 200x75
> 
> Is the principal question...
> 
> Thank you very much,
> 
> 	Grégoire
> ________________________________________________________________
> http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net

--Multipart_Tue__3_Dec_2002_09:23:33_-0200_085cc730
Content-Type: application/octet-stream;
 name="matroxfb_DAC1064.patch"
Content-Disposition: attachment;
 filename="matroxfb_DAC1064.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNS41MC9kcml2ZXJzL3ZpZGVvL21hdHJveC9tYXRyb3hmYl9EQUMxMDY0LmN+
CTIwMDItMTEtMjIgMTk6NDA6NDEuMDAwMDAwMDAwIC0wMjAwCisrKyBsaW51eC0yLjUuNTAvZHJp
dmVycy92aWRlby9tYXRyb3gvbWF0cm94ZmJfREFDMTA2NC5jCTIwMDItMTItMDMgMDk6MTg6MTAu
MDAwMDAwMDAwIC0wMjAwCkBAIC00MSw2ICs0MSw3IEBACiAjZGVmaW5lIG1pbmZvICgoc3RydWN0
IG1hdHJveF9mYl9pbmZvKilwdHIpCiAJbWF0cm94ZmJfREFDX2xvY2tfaXJxc2F2ZShmbGFncyk7
CiAJb3V0REFDMTA2NChQTUlORk8gTTEwNjRfWENVUkNUUkwsIGluREFDMTA2NChQTUlORk8gTTEw
NjRfWENVUkNUUkwpIF4gTTEwNjRfWENVUkNUUkxfRElTIF4gTTEwNjRfWENVUkNUUkxfWEdBKTsK
Kwlpbml0X3RpbWVyKCZBQ0NFU1NfRkJJTkZPKGN1cnNvci50aW1lcikpOwogCUFDQ0VTU19GQklO
Rk8oY3Vyc29yLnRpbWVyLmV4cGlyZXMpID0gamlmZmllcyArIEhaLzI7CiAJYWRkX3RpbWVyKCZB
Q0NFU1NfRkJJTkZPKGN1cnNvci50aW1lcikpOwogCW1hdHJveGZiX0RBQ191bmxvY2tfaXJxcmVz
dG9yZShmbGFncyk7Cg==

--Multipart_Tue__3_Dec_2002_09:23:33_-0200_085cc730--
