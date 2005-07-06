Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVGFVfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVGFVfK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVGFVfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:35:03 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:31108 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262539AbVGFVcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:32:16 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Jonathan Briggs <jbriggs@esoft.com>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu, ltd@cisco.com,
       gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       ninja@slaphack.com, vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <200507062033.j66KXNqM008212@laptop11.inf.utfsm.cl> (Horst von
 Brand's message of "Wed, 06 Jul 2005 16:33:23 -0400")
References: <hubert@uhoreg.ca>
	<200507062033.j66KXNqM008212@laptop11.inf.utfsm.cl>
X-Hashcash: 1:23:050706:vonbrand@inf.utfsm.cl::Hw5GqB9slG3HnbEB:0000000000000000000000000000000000000000g61h
X-Hashcash: 1:23:050706:jbriggs@esoft.com::bsLUp703UxTIb/ou:00000000000000000000000000000000000000000000bGJI
X-Hashcash: 1:23:050706:agmsmith@rogers.com::BJXJONCTT7zq2wN6:000000000000000000000000000000000000000001YA8o
X-Hashcash: 1:23:050706:ross.biro@gmail.com::XvIGHckj2tmLWU0J:000000000000000000000000000000000000000001UV4D
X-Hashcash: 1:23:050706:mrmacman_g4@mac.com::H9zyatPOH6c5Ud3R:0000000000000000000000000000000000000000000qWv
X-Hashcash: 1:23:050706:valdis.kletnieks@vt.edu::6AEb4ohyByh5i+Rh:00000000000000000000000000000000000000DaC7
X-Hashcash: 1:23:050706:ltd@cisco.com::WNRwvusnTYRqGTGq:0000Nvw9
X-Hashcash: 1:23:050706:gmaxwell@gmail.com::I3F+4Mc8BaceAM/F:0000000000000000000000000000000000000000000RovR
X-Hashcash: 1:23:050706:jgarzik@pobox.com::CHiJTSLYsCXpDanU:000000000000000000000000000000000000000000009vCK
X-Hashcash: 1:23:050706:hch@infradead.org::vStD153UZ7d91iTE:000000000000000000000000000000000000000000013e4W
X-Hashcash: 1:23:050706:akpm@osdl.org::mWOWvCWn6tOmBtPI:0000ur6Z
X-Hashcash: 1:23:050706:linux-kernel@vger.kernel.org::MHIG8oX/Bvr9B/cH:0000000000000000000000000000000027x4R
X-Hashcash: 1:23:050706:reiserfs-list@namesys.com::VmQ7kaFpOoPw/51E:0000000000000000000000000000000000001eZn
X-Hashcash: 1:23:050706:zam@namesys.com::Ce8imtfGXKp7j5tw:01QhDE
X-Hashcash: 1:23:050706:vs@thebsh.namesys.com::Outx+VsmK4YKF/r2:0000000000000000000000000000000000000000GLN8
X-Hashcash: 1:23:050706:ndiller@namesys.com::7JngQFbM25TKn1Xo:000000000000000000000000000000000000000001GnMm
X-Hashcash: 1:23:050706:ninja@slaphack.com::5VKTVSNOsHbNTyzn:0000000000000000000000000000000000000000000BR27
X-Hashcash: 1:23:050706:vitaly@thebsh.namesys.com::nx9+sgMsArqkkWil:000000000000000000000000000000000000DDUy
Date: Wed, 06 Jul 2005 17:31:58 -0400
Message-ID: <87ackzei41.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (services106.cs.uwaterloo.ca [129.97.152.132]); Wed, 06 Jul 2005 17:32:06 -0400 (EDT)
X-Miltered: at persephone with ID 42CC4D9C.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2005 16:33:23 -0400, Horst von Brand <vonbrand@inf.utfsm.cl> said:

> Hubert Chan <hubert@uhoreg.ca> wrote:
>> If you can store the parents, then finding cycles (relatively)
>> quickly is pretty easy: before you try to make A the parent of B,
>> walk up the parent pointers starting from A.  If you ever reach B,
>> you have a cycle.  If not, you don't have a cycle.  (Hmmm.  Do I need
>> a proof of correctness for this?  It's just depth-first-search, which
>> everybody learned in their first algorithms course.)

> Correct. And you need space for potentially a huge lot of up pointers
> for each file.

People (that I know of) don't normally have a huge lot of hardlinks to a
single file.

> And then there is the (very minor) problem is that meanwhile /nothing/
> can touch the filesystem to do any change...

If the DFS is quick, it shouldn't make much difference.

Lock nodes as you walk up the tree, and people can change unlocked nodes
without harming anything.  All you need to do is make sure that no up
pointers get added to nodes that you've already looked at.

People can also still edit files without changing the tree (and hence
not screwing up the DFS).

> How do you delete such an object? You will have to delete from each
> child down to the first object that has a pointer to it from the
> outside, if you don't want garbage left behind. And that means walking
> down to /each/ reachable object, then walking up from there to see if
> all its parents are in the DAG rooted at what you are going to
> delete. This means potentially walking through the whole filesystem
> (if you want to delete the root, or something near). You will run out
> of memory, and again, meanwhile no changes can be allowed.

What does deleting have to do with up pointers?  If you delete a
directory that has refcount greater than 1, you decrease the refcount,
remove the appropriate up pointer, and remove the inode entry from its
parent.  If you delete a directory that has refcount equal to 1, well,
we're in the same situation we're in right now when you delete a
directory; you need to "rm -r", which doesn't lock up the whole
filesystem.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

