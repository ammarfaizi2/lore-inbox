Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262989AbVF3QB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbVF3QB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbVF3QBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:01:08 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:35520 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262989AbVF3P5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 11:57:50 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Hans Reiser <reiser@namesys.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <20050630062956.GP16867@khan.acc.umu.se> (David Weinehall's
 message of "Thu, 30 Jun 2005 08:29:56 +0200")
References: <hubert@uhoreg.ca>
	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>
	<8783be6605062914341bcff7cb@mail.gmail.com>
	<42C3615A.9020600@namesys.com> <871x6kv4zd.fsf@evinrude.uhoreg.ca>
	<20050630062956.GP16867@khan.acc.umu.se>
X-Hashcash: 1:23:050630:reiser@namesys.com::1+U1CkHnXsRGc4T/:00000000000000000000000000000000000000000009aLv
X-Hashcash: 1:23:050630:vonbrand@inf.utfsm.cl::0sgkgtLwyjiPlZzr:0000000000000000000000000000000000000000108U
X-Hashcash: 1:23:050630:mrmacman_g4@mac.com::pJMb/UX11KozJ3MC:000000000000000000000000000000000000000000byby
X-Hashcash: 1:23:050630:ninja@slaphack.com::WLQ0+ERu/4sSWEQr:00000000000000000000000000000000000000000012Sb/
X-Hashcash: 1:23:050630:valdis.kletnieks@vt.edu::SiYXr3ftb/7McHnX:00000000000000000000000000000000000000NA0P
X-Hashcash: 1:23:050630:ltd@cisco.com::J+8HfNCEMz+pwhBr:0000EeJI
X-Hashcash: 1:23:050630:gmaxwell@gmail.com::0L/eXUAiuP3t1PdO:00000000000000000000000000000000000000000003sEs
X-Hashcash: 1:23:050630:jgarzik@pobox.com::dIdJupMAoAxuDGkj:00000000000000000000000000000000000000000000U/TW
X-Hashcash: 1:23:050630:hch@infradead.org::RVWt+1PzAcD3qoPj:0000000000000000000000000000000000000000000021mv
X-Hashcash: 1:23:050630:akpm@osdl.org::e1Shon5f+s01/Qjm:0000TVGO
X-Hashcash: 1:23:050630:linux-kernel@vger.kernel.org::kaWUYjzAv+POM8yR:0000000000000000000000000000000017xxC
X-Hashcash: 1:23:050630:reiserfs-list@namesys.com::dEQAogopwLUh23S4:000000000000000000000000000000000000KrIj
Date: Thu, 30 Jun 2005 11:57:27 -0400
Message-ID: <87psu3vnvc.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at rhadamanthus with ID 42C416AD.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2005 08:29:56 +0200, David Weinehall <tao@acc.umu.se> said:

> On Thu, Jun 30, 2005 at 12:33:10AM -0400, Hubert Chan wrote:
>> It's sort of like the way web servers handle index.html, for those
>> who think it's a stupid idea.  (Of course, some people may still
>> think it's a stupid idea... ;-) )

> And guess what?  That's handled on the web server level (userland),
> not by the file system.  So different web servers can handle it
> differently (think index.html.sv, index.html.zh, index.php, etc).

>From the web *browser*'s point of view, it is handled by the
"filesystem" (which is provided by the various servers).  The browser
doesn't care how or where the data is stored.  It just requests a file,
and gets some data back.  So the browser doesn't have to check for
http://www.example.com/, get a failure (trying to read a directory),
check for http://www.example.com/index.html, etc.  In this way, the web
server controls (which I think takes the place of the filesystem in this
case) what gets shown (index.html.sv, etc.), instead of the leaving it
up to the browser.

In the same way, you don't want every single user program to have to
guess whether it should look at .data, or .contents, or whatever.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

