Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266677AbUHIOwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266677AbUHIOwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUHIOjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:39:51 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:743 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S266677AbUHIOge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:36:34 -0400
Date: Mon, 9 Aug 2004 10:36:28 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <200408091224.i79COp69009736@burner.fokus.fraunhofer.de>
Message-ID: <Pine.LNX.4.58.0408091019370.6173@vivaldi.madbase.net>
References: <200408091224.i79COp69009736@burner.fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Aug 2004, Joerg Schilling wrote:
> >From: Eric Lammerts <eric@lammerts.org>
>
> >On Fri, 6 Aug 2004, Joerg Schilling wrote:
> >> The CAM interface (which is from the SCSI standards group)
> >> usually is implemeted in a way that applications open /dev/cam and
> >> later supply bus, target and lun in order to get connected
> >> to any device on the system that talks SCSI.
> >>
> >> Let me repeat: If you believe that this is a bad idea, give very
> >> good reasons.
>
> >With this interface, how do you grant non-root users access to a CD
> >writer, but prevent them from directly accessing a SCSI harddisk?
>
> On Linux, it is impossible to run cdrecord without root privilleges.
> Make cdrecord suid root, it has been audited....
>
> On Solaris, there is ACLs, RBAC & getppriv() / setppriv()

Interesting. How do you use those to grant someone access to a
particular CD writer device behind /dev/cam _without_ at the same time
granting them access to other SCSI devices too? I know that it's
possible with a trusted binary (like cdrecord) that's setuid root, or
that gets some priviledges some other way, but if that is the _only_
way, then that's a flaw in the CAM interface.

On Linux you can simply change permissions on the CD writer's device
node to allow non-root users to burn CDs.

Eric
