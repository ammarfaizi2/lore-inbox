Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVF0PXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVF0PXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVF0PXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:23:43 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:43993 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261662AbVF0O6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:58:22 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Valdis.Kletnieks@vt.edu
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <200506270459.j5R4xdZp005659@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Mon, 27 Jun 2005 00:59:39 -0400")
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
	<42BCD93B.7030608@slaphack.com>
	<200506251420.j5PEKce4006891@turing-police.cc.vt.edu>
	<42BDA377.6070303@slaphack.com>
	<200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>
	<42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com>
	<e692861c05062522071fe380a5@mail.gmail.com>
	<42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com>
	<200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>
	<42BF08CF.2020703@slaphack.com>
	<200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
	<42BF2DC4.8030901@slaphack.com>
	<200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
	<87y88webpo.fsf@evinrude.uhoreg.ca>
	<200506270459.j5R4xdZp005659@turing-police.cc.vt.edu>
X-Hashcash: 1:23:050627:valdis.kletnieks@vt.edu::Pqy/WJGteOrpYkln:00000000000000000000000000000000000000lA1V
X-Hashcash: 1:23:050627:ltd@cisco.com::KSl/yoJ0x2by9bZ1:0000pO3D
X-Hashcash: 1:23:050627:gmaxwell@gmail.com::kLNHzZWK93wz23tK:00000000000000000000000000000000000000000006zUK
X-Hashcash: 1:23:050627:reiser@namesys.com::2JeWsytQpDVIIqHd:00000000000000000000000000000000000000000008C6z
X-Hashcash: 1:23:050627:vonbrand@inf.utfsm.cl::WwxOK6DEUPyKx+IW:0000000000000000000000000000000000000000ftFg
X-Hashcash: 1:23:050627:jgarzik@pobox.com::6oWKSsl25ik0ptqw:000000000000000000000000000000000000000000001X80
X-Hashcash: 1:23:050627:hch@infradead.org::ye76Rp2JOMtrlzY9:00000000000000000000000000000000000000000001QzUR
X-Hashcash: 1:23:050627:akpm@osdl.org::ozYSRFa6HPfDryiW:0000AsBB
X-Hashcash: 1:23:050627:linux-kernel@vger.kernel.org::e4Lodei/MHiXvULs:0000000000000000000000000000000000EZH
X-Hashcash: 1:23:050627:reiserfs-list@namesys.com::djdlP1OlfP6HyKf9:0000000000000000000000000000000000003jlY
Date: Mon, 27 Jun 2005 10:58:02 -0400
Message-ID: <873br3u9s5.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at rhadamanthus with ID 42C01434.006 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005 00:59:39 -0400, Valdis.Kletnieks@vt.edu said:

> On Sun, 26 Jun 2005 23:10:43 EDT, Hubert Chan said:
>> On Sun, 26 Jun 2005 20:40:29 -0400, Valdis.Kletnieks@vt.edu said:

>> Oh, I'm waiting for the fun the first time somebody deploys a
>> plugin that has similar semantics to 'chmod g+s dirname/' ;)

> (You *did* notice it was set-GID of a *directory* not an executable
> file, right?)

>> Reiser4 plugins have to be compiled into the kernel.  (They're not
>> plugins in the sense that most people use that word.)  And any admin
>> who would compile that kind of plugin into the kernel needs to have
>> his head

> Oh?  You saying that it *wont* be permitted for a user to say:

[...]

Sorry.  I completely misunderstood what you were getting at.  I thought
that you were implying that with the right kind of plugin, users would
be able to get around security measures.  Of course, this is probably
true, which means that plugins need to be coded carefully (as with
everything else in the kernel).  My point that I was trying to make was
that users can't install arbitrary plugins, and the set of plugins
available is controlled by the administrator.

Since that wasn't what you were talking about, I retract my previous
email.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

