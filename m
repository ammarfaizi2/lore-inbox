Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVFUMHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVFUMHr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVFUMFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:05:11 -0400
Received: from relay.rost.ru ([80.254.111.11]:9383 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S261302AbVFUMBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:01:31 -0400
Date: Tue, 21 Jun 2005 16:01:27 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050621120127.GA4695@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.9i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 171, 06 20, 2005 at 11:54:58 -0700, Andrew Morton wrote:
>=20
> This summarises my current thinking on various patches which are presently
> in -mm.  I cover large things and small-but-controversial things.  Anythi=
ng
> which isn't covered here (and that's a lot of material) is probably a "wi=
ll
> merge", unless it obviously isn't.
>=20
> (If you reply to this email it would be a good idea to alter the Subject:
> to reflect which feature you are discussing)
>=20
>=20
>=20
> git-ocfs
>=20
>     The OCFS2 filesystem.  OK by me, although I'm not sure it's had enough
>     review.
>=20
> sparsemem
>=20
>     OK by me for a merge.  Need to poke arch maintainers first, check that
>     they've looked at it sufficiently closely.
>=20
> vm-early-zone-reclaim
>=20
>     Needs some convincing benchmark numbers to back it up.  Otherwise OK.
>=20
> avoiding-mmap-fragmentation
>=20
>     Tricky.  Addresses vm area fragmentation issues due to recent
>     optimisations to the free-area lookup code.  Will merge.
>=20
> periodically-drain-non-local-pagesets
>=20
>     Will merge
>=20
> pcibus_to_node and users
>=20
>     Will merge
>=20
> CONFIG_HZ for x86 and ia64: changes default HZ to 250, make HZ Kconfigura=
ble.
>=20
>     Will merge (will switch default to 1000 Hz later if that seems necess=
ary)
>=20
> dmi-*.patch
>=20
>     Will merge.  I have a comment "The below break x440".  Maybe it got
>     fixed.  We'll doubtless hear if not.

Fixed, patch merged in -mm as dmi-move-acpi-sleep-quirk-fix.patch

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D111829134708641&w=3D2
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D111832375203467&w=3D2

> xen-*.patch
>=20
>     These are little cleanups and abstractions which make a Xen merge
>     easier.  May as well merge them.
>=20
> CPU hotplug for x86 and x86_64
>=20
>     Not really useful on current hardware, but these provide
>     infrastructure which some power management patches need, and it seems
>     sensible to make the reference architecture support hotplug.  Will me=
rge.
>=20
> swsusp-on-SMP
>=20
>     Will merge.
>=20
> cfq version 3
>=20
>     Not sure.  Jens seems to be setting up a few git trees.  On hold.
>=20
> RCUification of the key management code
>=20
>     Don't know - dhowells seemed diffident last time we discussed this.
>=20
> timers-fixes-improvements.patch
>=20
>     SMP speedups for the core timer code.  It was bumpy, but this seems
>     stable now.  Will merge.
>=20
> kprobes-*
>=20
>     Will merge
>=20
> rapidio-*
>=20
>     Will merge.
>=20
> namespace*.patch
>=20
>     Awaiting viro ack.
>=20
> xtensa architecture
>=20
>     Is xtensa now, or will it be in the future a sufficiently popular
>     architecture to justify the cost of having this code in the tree?
>=20
>     Heaven knows.  Will merge.
>=20
> dlm-*.patch: Red Hat distributed lock manager
>=20
>     Hard.  Right now it seems that no in-kernel projects will use this and
>     only one out-of-kernel project will use it.  Shelve the problem until
>     after Kernel Summit, where some light may be shed.
>=20
>     Opinions are sought...
>=20
> connector.patch
>=20
>     Nice idea IMO, but there are still questions around the
>     implementation.  More dialogue needed ;)
>=20
> connector-add-a-fork-connector.patch
>=20
>     OK, but needs connector.
>=20
> inotify
>=20
>     There are still concerns about the userspace API and internal
>     implementation details.  More slogging needed.
>=20
> pcmcia-*.patch
>=20
>     Makes the pcmcia layer generate hotplug events and deprecates cardmgr.
>     Will merge.
>=20
> NUMA-aware slab allocator
>=20
>     Seems stable now, but it needs some ifdef reduction work before
>     merging, please.
>=20
> CPU scheduler
>=20
>     Will merge some of these patches.  We're still discussing which ones.
>=20
> perfctr
>=20
>     Not yet, but getting closer.  The PPC64 guys still need to sort out a
>     few interface issues with Mikael.  We might be able to fit this into
>     2.6.13 if people get a move on.
>=20
> cachefs
>=20
>     This is a ton of code which knows rather a lot about pagecache
>     internals.  It allows the AFS client to cache file contents on a local
>     blockdev.
>=20
>     I don't think it's a justified addition for only AFS and I'd prefer to
>     see it proven for NFS as well.
>=20
>     Issues around add-page-becoming-writable-notification.patch need to
>     be resolved.
>=20
> cachefs-for-nfs
>=20
>     A recent addition.  Needs review from NFS developers and considerably
>     more testing.
>=20
>     These things aren't looking likely for 2.6.13.
>=20
> kexec and kdump
>=20
>     I guess we should merge these.
>=20
>     I'm still concerned that the various device shutdown problems will
>     mean that the success rate for crashing kernels is not high enough for
>     kdump to be considered a success.  In which case in six months time w=
e'll
>     hear rumours about vendors shipping wholly different crashdump
>     implementations, which would be quite bad.
>=20
>     But I think this has gone as far as it can go in -mm, so it's a bit of
>     a punt.
>=20
> reiser4
>=20
>     Merge it, I guess.
>=20
>     The patches still contain all the reiser4-specific namespace
>     enhancements, only it is disabled, so it is effectively dead code.  M=
aybe
>     we should ask that it actually be removed?
>=20
> v9fs
>=20
>     I'm not sure that this has a sufficiently high
>     usefulness-to-maintenance-cost ratio.
>=20
> fuse
>=20
>     This is useful, but there are, AFAIK, two issues:
>=20
>     - We're still deadlocked over some permission-checking hacks in there
>=20
>     - It has an NFS server implementation which only works if the
>       to-be-served file happens to be in dcache.
>=20
>       It has been said that a userspace NFS server can be used to get
>       full NFS server functionality with FUSE.  I think the half-assed ke=
rnel
>       implementation should be done away with.
>=20
> execute-in-place
>=20
>     Will merge.  Have the embedded guys commented on the usefulness of
>     this for execute-out-of-ROM?
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCuAGXR2OTnxNuAyMRAsLHAJ9LgvSv1PubHTQRtBdq5BpMbHhT5QCgsyIW
aXiXA3orr7YV6GY819jEWm0=
=Iib4
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
