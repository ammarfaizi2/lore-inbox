Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVGSQTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVGSQTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 12:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVGSQRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 12:17:33 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:33176 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261528AbVGSQQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 12:16:34 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci_find_device --> pci_get_device
Date: Tue, 19 Jul 2005 18:20:20 +0200
User-Agent: KMail/1.8.1
Cc: Jiri Slaby <jirislaby@gmail.com>, rth@twiddle.net, dhowells@redhat.com,
       kumar.gala@freescale.com, davem@davemloft.net, mhw@wittsend.com,
       support@comtrol.com, Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       nils@kernelconcepts.de, cjtsai@ali.com.tw, Lionel.Bouton@inet6.fr,
       benh@kernel.crashing.org, mchehab@brturbo.com.br, laredo@gnu.org,
       rbultje@ronald.bitfreak.net, middelin@polyware.nl, philb@gnu.org,
       tim@cyberelk.net, campbell@torque.net, andrea@suse.de,
       linux@advansys.com, chirag.kantharia@hp.com, mulix@mulix.org
References: <42DC4873.2080807@gmail.com> <200507191327.44415@bilbo.math.uni-mannheim.de> <42DD1FCF.4050304@gmail.com>
In-Reply-To: <42DD1FCF.4050304@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1360345.T2YvWR61yh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507191820.35472@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1360345.T2YvWR61yh
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag, 19. Juli 2005 17:44 schrieb Jiri Slaby:
>Rolf Eike Beer napsal(a):
>>Jiri Slaby wrote:
>>>Kernel version: 2.6.13-rc3-git4
>>>
>>>* This patch removes from kernel tree pci_find_device and changes
>>>it with pci_get_device. Next, it adds pci_dev_put, to decrease reference
>>>count of the variable.
>>>* Next, there are some (about 10 or so) gcc warning problems (i. e.
>>>variable may be unitialized) solutions, which were around code with old
>>>pci_find_device.
>>
>>Is this the reason why you initialize members of static structs? If this =
is
>>uninitialized it will end in the bss section and will be zeroed before the
>>kernel uses is. If you do it will go into data section and add more bloat
>> to the binary. At least this is the explanation I got once why not to do
>> this.
>
>I can't find now changes of initialization static variables, but i have
>deleted section
>dealing up with gcc warning from patch, it would go on a queue later.

Sorry, I misread the diff. That are static functions with the variables in=
=20
them, not static structs.

Your patch to arch/sparc64/kernel/ebus.c is broken, the removed and added=20
parts do not match in behaviour.

If you add braces after if's please add the '{' in the same line as the if=
=20
itself. This will make the diff bigger, but then this matches=20
Documentation/Coding-style.

Eike

--nextPart1360345.T2YvWR61yh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD4DBQBC3ShTXKSJPmm5/E4RAvh+AJiv22LqBjUUvCqgBcXToJM3Mh96AJ4vSDxe
ln7aqBIeefMYI2AgYPRFqQ==
=qHej
-----END PGP SIGNATURE-----

--nextPart1360345.T2YvWR61yh--
