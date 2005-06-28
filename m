Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVF1CXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVF1CXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 22:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVF1CXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 22:23:38 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:9422 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262381AbVF1CVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 22:21:55 -0400
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
In-Reply-To: <42C08B5E.2080000@slaphack.com> (David Masover's message of
 "Mon, 27 Jun 2005 18:27:26 -0500")
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
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
	<42BF667C.50606@slaphack.com>
	<5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com>
	<42BF7167.80201@slaphack.com>
	<EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com>
	<42C06D59.2090200@slaphack.com>
	<CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com>
	<42C08B5E.2080000@slaphack.com>
X-Hashcash: 1:23:050628:ninja@slaphack.com::xc3SIXzWN+2svjIi:0000000000000000000000000000000000000000000Sk4X
X-Hashcash: 1:23:050628:valdis.kletnieks@vt.edu::Uxcph+cC1J4iNEJU:000000000000000000000000000000000000003xZR
X-Hashcash: 1:23:050628:ltd@cisco.com::jQLsW4XoTSMfKhVU:0000lmvT
X-Hashcash: 1:23:050628:gmaxwell@gmail.com::nAKMUxuG1uCSMPQJ:00000000000000000000000000000000000000000003nWl
X-Hashcash: 1:23:050628:reiser@namesys.com::rb+nMSYpLU2i3m4P:0000000000000000000000000000000000000000000pTyg
X-Hashcash: 1:23:050628:vonbrand@inf.utfsm.cl::LFuaqNXwBfv5+c7D:0000000000000000000000000000000000000001SCLS
X-Hashcash: 1:23:050628:jgarzik@pobox.com::rDTeEISThieg3usR:000000000000000000000000000000000000000000007McH
X-Hashcash: 1:23:050628:hch@infradead.org::sL+Jfb5QIvdNLkoq:00000000000000000000000000000000000000000000ZwNB
X-Hashcash: 1:23:050628:akpm@osdl.org::bic4lfHOCjSrKlZ6:00003wZE
X-Hashcash: 1:23:050628:linux-kernel@vger.kernel.org::hSddbIjYQQ6f+39y:000000000000000000000000000000000LBGr
X-Hashcash: 1:23:050628:reiserfs-list@namesys.com::zxJJWv+DtI8H3CLC:0000000000000000000000000000000000009Lw6
Date: Mon, 27 Jun 2005 22:21:35 -0400
Message-ID: <87y88vrzkg.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at rhadamanthus with ID 42C0B46C.003 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005 18:27:26 -0500, David Masover <ninja@slaphack.com> said:

> Kyle Moffett wrote:
>> I think the '...' is just a bad idea in general, because it breaks
>> tar and such.  An interface like this might be simpler to design and
>> use:
>> 
>> # mkdir /attr
>> # mount -t attrfs attrfs /attr
>> 
>> /attr/fd/$FD_NUM == '...' directory for a filedescriptor
>> /attr/fs/$DEV_NUM/$INODE_NUM == '...' directory for an inode

The most obvious (at least obvious for me) complaint about this is that
the attributes are separate from the file.  (In other words, it's a bit
ugly. ;-) ) So if you want to backup a file, along with all its
(extended) attributes (or substreams, or ... etc. ...), you need to
backup the file, and find the appropriate /attr/fs/$DEV_NUM/$INODE_NUM
and back that up.  If I want to edit an attribute, I need to find
$DEV_NUM and $INODE_NUM (which I have no idea how to do), rather than
just "edit foo/.../extended_attribute".  (Or using your "getattrpath"
command, it would be a two-step process -- run getattrpath, then run
editor -- rather than a one-step process.  Of course, this is only
mildly annoying.)

It also exposes a difference between attributes and regular files.
e.g. can I add attributes to an attribute?  (say, I have a thumbnail
attribute for the file ~/foo, and I want to add a mime-type attribute to
that thumbnail attribute.)  If you want to allow it, you have to be
careful not to run into a big loop generating an infinite number of
inodes in the attrfs. (e.g.
/attr/fs/$(getattrpath /attr/fs/$(getattrpath ~/foo)/thumbnail)/mimetype
-- attrfs shouldn't generate the inode for that until
/attr/fs/$(getattrpath~/foo)/thumbnail is accessed, and maybe not even
then...)

That said, I prefer that interface over xattr or openat.

>> It would be usable from a shell with a simple "getattrpath" command
>> which returns "fs/$DEV_NUM/$INODE_NUM" by stat-ing any given path.

> Still pretty annoying, but maybe a good idea, especially if the shell
> gets extended to support it.  Not sure I like using inode numbers,
> though -- I like the idea of being able to symlink to stuff inside the
> meta-file dir.

The advantage of using inodes rather than pathnames is that it is robust
with respect to file renaming/moving.  It also allows things like
adding attributes to symlinks (since the inode number for a symlink is
different from the inode number for the file that it points to).

You can still symlink.  It just takes a little more effort to figure out
what $DEV_NUM/$INODE_NUM to use.

> Actually, I like this.  Give me some time to let it percolate.

> Hans, thoughts?  Seems to be namespace fragmentation, but seems
> usable, less breakage, and so on.  And should it be /attr or /meta?

For the mount point, it doesn't matter; it's up to the user.  It's the
attrfs or metafs or ???fs that matters (but which will greatly influence
whether people user /attr or /meta).

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

