Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUFUIB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUFUIB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 04:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266151AbUFUIB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 04:01:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46013 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266149AbUFUIBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 04:01:51 -0400
Date: Mon, 21 Jun 2004 10:01:29 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4]Diskdump Update
Message-ID: <20040621080129.GA27569@devserv.devel.redhat.com>
References: <1086954645.2731.23.camel@laptop.fenrus.com> <DBC45765BB709Eindou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <DBC45765BB709Eindou.takao@soft.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 21, 2004 at 04:59:52PM +0900, Takao Indoh wrote:
> Hi,
> 
> Now I am fixing diskdump according to comments by you and Christoph.
> 
> On Fri, 11 Jun 2004 13:50:45 +0200, Arjan van de Ven wrote:
> 
> >> +#ifdef CONFIG_PROC_FS
> >> +static int proc_ioctl(struct inode *inode, struct file *file, unsigned 
> >> int cmd, unsigned long param)
> >
> >
> >ehhh this looks evil
> 
> Do you mean I should use not ioctl but the following style?
> 
> echo "add /dev/hda1" > /proc/diskdump
> echo "delete /dev/hda1" > /proc/diskdump

well no since /dev/hda is pointless; major/minor pairs maybe.
But why in /proc???? it sounds like a sysfs job to me, where you probably
want to represent a dump relationship with a symlink, and use "rm" to remove
an entry..


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA1pXZxULwo51rQBIRAnBsAJ4sVtwPpO4wwviJ0yP8gQ9fGvxeGgCdFPvB
q/bZttm50edVBBmqrhvKYaQ=
=aGhI
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
