Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVGEU5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVGEU5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 16:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVGEU5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 16:57:54 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:52445 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261856AbVGEUzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 16:55:47 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Chet Hosey <chosey@nauticom.net>
Cc: Kevin Bowen <kevin@ucsd.edu>, Hans Reiser <reiser@namesys.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <42C4F38C.9020000@nauticom.net> (Chet Hosey's message of "Fri,
 01 Jul 2005 03:41:00 -0400")
References: <200507010328.j613SV3h004647@laptop11.inf.utfsm.cl>
	<42C4F38C.9020000@nauticom.net>
X-Hashcash: 1:23:050705:chosey@nauticom.net::Je9f4nkP1SM92UvF:000000000000000000000000000000000000000002avEp
X-Hashcash: 1:23:050705:kevin@ucsd.edu::u8vwULQZFi6gI4jl:0000hbg
X-Hashcash: 1:23:050705:reiser@namesys.com::7IXSc9U93zWl+MPk:00000000000000000000000000000000000000000002uoL
X-Hashcash: 1:23:050705:mrmacman_g4@mac.com::BSQ9JbzcVwqjpKIR:000000000000000000000000000000000000000000hKXU
X-Hashcash: 1:23:050705:ninja@slaphack.com::HrMCQwWdov9igfW8:0000000000000000000000000000000000000000000olI+
X-Hashcash: 1:23:050705:valdis.kletnieks@vt.edu::h1B8KdK7/7G98y6F:000000000000000000000000000000000000008FaZ
X-Hashcash: 1:23:050705:ltd@cisco.com::u1lcPnKRSI+EgYSa:0000DlyW
X-Hashcash: 1:23:050705:gmaxwell@gmail.com::wNjEra+cjTjugM8X:00000000000000000000000000000000000000000007Rz0
X-Hashcash: 1:23:050705:jgarzik@pobox.com::noT+Pv+1DRVW2z/T:00000000000000000000000000000000000000000000BI95
X-Hashcash: 1:23:050705:hch@infradead.org::vcjcHzeGn9CXbE4/:00000000000000000000000000000000000000000000fN3Z
X-Hashcash: 1:23:050705:akpm@osdl.org::Jz3fLheXH73VnF4D:0002ZjQT
X-Hashcash: 1:23:050705:linux-kernel@vger.kernel.org::FC0WdvUZky7cBdcB:0000000000000000000000000000000009+X6
X-Hashcash: 1:23:050705:reiserfs-list@namesys.com::7paiTxi9xsMA7DUS:000000000000000000000000000000000001QSeQ
Date: Tue, 05 Jul 2005 16:55:33 -0400
Message-ID: <87pstxynui.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (services106.cs.uwaterloo.ca [129.97.152.132]); Tue, 05 Jul 2005 16:55:41 -0400 (EDT)
X-Miltered: at demeter with ID 42CAF39F.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jul 2005 03:41:00 -0400, Chet Hosey <chosey@nauticom.net> said:

> Horst von Brand wrote:
>> And who says that a normal user isn't allowed to annotate each and
>> every file with its purpose or something else?

Explain how you currently allow users to annotate arbitrary files.

>> I can very well imagine a system in which users (say students in a
>> Linux class) want to do so... on a shared machine. Or users having a
>> shared MP3 or photograph or ... collection, with individual notes on
>> each. Or even developers wanting to annotate source code files with
>> their comments, but leave them read-only (or have them under SCM).

> This same argument could be used to attack the idea of group
> permissions -- that groups of users might have conflicting
> goals. Implementing metadata in userspace via bundled files has the
> same drawback.

The situation is even better with file-as-dir.  If the administrator
wants to allow users to edit the description metadata for the file foo,
the administrator can set the appropriate permissions for
foo/.../description, and keep foo read-only.

>>Kevin Bowen <kevin@ucsd.edu> wrote:
>>> If you're sysadmining a multiuser reiser4 box, and your users are
>>> able to modify the metadata of files they don't own, then you go to
>>> sysadmin purgatory.

Actually, you could use something like unionfs to allow users to keep
their own annotations without affecting everyone else's.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

