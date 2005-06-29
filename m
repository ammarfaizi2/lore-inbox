Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVF2B6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVF2B6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVF2Byi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:54:38 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:43951 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262328AbVF2Bvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 21:51:35 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: David Masover <ninja@slaphack.com>
Cc: Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <42C1B19F.6010808@slaphack.com> (David Masover's message of
 "Tue, 28 Jun 2005 15:22:55 -0500")
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
	<200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>
	<42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com>
	<e692861c05062522071fe380a5@mail.gmail.com>
	<42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com>
	<200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>
	<42BF08CF.2020703@slaphack.com>
	<200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
	<42BF2DC4.8030901@slaphack.com>
	<200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
	<42BF667C.50606@slaphack.com>
	<5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com>
	<42BF7167.80201@slaphack.com>
	<EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com>
	<42C06D59.2090200@slaphack.com>
	<CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com>
	<42C08B5E.2080000@slaphack.com> <87y88vrzkg.fsf@evinrude.uhoreg.ca>
	<42C1B19F.6010808@slaphack.com>
X-Hashcash: 1:23:050629:ninja@slaphack.com::7l6AsCX7V3AJrjBG:0000000000000000000000000000000000000000001Syx9
X-Hashcash: 1:23:050629:valdis.kletnieks@vt.edu::X4lDeEmnpzXdmAsE:000000000000000000000000000000000000001Y6D
X-Hashcash: 1:23:050629:ltd@cisco.com::KPAmDwc5mkv5YxZm:0001Gg+g
X-Hashcash: 1:23:050629:gmaxwell@gmail.com::EG+VWm4Ma+pLc1TM:0000000000000000000000000000000000000000000VsAG
X-Hashcash: 1:23:050629:reiser@namesys.com::yVNXaoHxYgeE1VW2:0000000000000000000000000000000000000000000R8io
X-Hashcash: 1:23:050629:vonbrand@inf.utfsm.cl::eGwTwBrCYdPSluf0:0000000000000000000000000000000000000000qP+r
X-Hashcash: 1:23:050629:jgarzik@pobox.com::hArWpqKOS1DeV01o:00000000000000000000000000000000000000000000Tr8K
X-Hashcash: 1:23:050629:hch@infradead.org::brqOK4xCqDYcdLAS:00000000000000000000000000000000000000000000wmvG
X-Hashcash: 1:23:050629:akpm@osdl.org::tUWmXBS3w/I3P88/:0000XV/X
X-Hashcash: 1:23:050629:linux-kernel@vger.kernel.org::VtBbmWfkSvux0xM2:000000000000000000000000000000000L/GP
X-Hashcash: 1:23:050629:reiserfs-list@namesys.com::7M3vlMckmqXMUQ0Y:000000000000000000000000000000000000S7Cp
Date: Tue, 28 Jun 2005 21:51:08 -0400
Message-ID: <87wtoedj77.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at minos with ID 42C1FE8A.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005 15:22:55 -0500, David Masover <ninja@slaphack.com> said:

> Come to think of it, that changes the proposal a bit.  You need a
> different way to access the meta-dir for files than for directories,
> if we're going to support /meta/vfs.  No biggie:

> /meta/vfs/file/home/bob/sue.mpg/acl
> /meta/vfs/dir/home/bob/acl

What if /home has an extended attribute named bob?  Then is
/meta/vfs/dir/home/bob a file or a directory?

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

