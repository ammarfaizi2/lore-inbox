Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268317AbUIBNuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268317AbUIBNuM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 09:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268321AbUIBNuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 09:50:12 -0400
Received: from mynah.mail.pas.earthlink.net ([207.217.120.228]:32689 "EHLO
	mynah.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S268317AbUIBNt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 09:49:59 -0400
Message-ID: <41372501.8050600@monolith3d.com>
Date: Thu, 02 Sep 2004 06:49:53 -0700
From: John Myers <electronerd@monolith3d.com>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: christer@weinigel.se, linux-kernel@vger.kernel.org, der.eremit@email.de,
       axboe@suse.de
Subject: Re: (was: Re: PATCH: cdrecord: avoiding scsi device numbering for
 ide devices)
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it> <2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it> <2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it> <2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner> <412889FC.nail9MX1X3XW5@burner> <Pine.LNX.4.58.0408221450540.297@neptune.local> <m37jrr40zi.fsf@zoo.weinigel.se> <4134FA0B.6030404@monolith3d.com> <4136EB75.nailB22112H09@burner>
In-Reply-To: <4136EB75.nailB22112H09@burner>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ELNK-Trace: 8839a2c17b2169aa1aa676d7e74259b7b3291a7d08dfec79b20945f58cc187e264f33d562d83fb03350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 66.122.68.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joerg Schilling wrote:
| John Myers <electronerd@monolith3d.com> wrote:
|
|
|>I hope this is not a stupid idea:
|>
|>I propose a finer-grained approach to suid-root binaries. Perhaps,
|>instead of having a single flag giving the binary all the rights and
|>responsibilities of its owner, there could be a table/list/something of
|>capabilities which we want to grant to the binary. This, of course,
|>would be a privileged operation (perhaps a new capability?).
|>
|>For example, we might want to grant cdrecord CAP_SYS_RAWIO. This way, we
|>don't have to worry about cdrecord running as root and not dropping all
|>the capabilities it doesn't need, by accident or by malice.
|
|
| cdrecord neither does drop the privileges by accident nor by malice.

I wasn't trying to insult cdrecord, or even suggest it might have the
inkling of a possibility of this type of issue, and I am sorry if I made
it sound that way. I was merely trying to illustrate a use of my
proposal. I admit, I should have invented a name, like
cd-burning-fire-toaster-program to illustrate the separation of my
example from any actual existing implementation

| What I however see is that a completely unneeded incompatible
interface change
| has been applied to a _stable_ Kernel.

I really wasn't talking about that. I was, however, trying to offer a
solution that would, perhaps, allow both this change, and cdrecord, to
co-exist peacefully, without running cdrecord as root.

|
| On a cleanly designed OS with fine grained permissions, a program like
cdrecord
| does not need to worry about the permissions as it gets exactly the
needed
| permissions granted by the execution environment.
|
| Jörg
|

Which is exactly what I proposed...


So... could anyone comment on my proposal, rather than just flame my
examples?

- --
electronerd (jonathan s myers)
code poet and recycle bin monitor
programmer, monolith3d.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBNyUBNh5QaxZowccRAtGYAJ4gLta/cmcRpDQoDf3u1bdEdx8vKwCgikzM
xVI2EyH2pwRbUI/KgLGP7YQ=
=Sxlq
-----END PGP SIGNATURE-----

