Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268402AbTBYXoU>; Tue, 25 Feb 2003 18:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268407AbTBYXoU>; Tue, 25 Feb 2003 18:44:20 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:20920 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S268402AbTBYXoT>; Tue, 25 Feb 2003 18:44:19 -0500
Date: Tue, 25 Feb 2003 23:51:45 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
       alistair@devzero.co.uk, cloos@jhcloos.com, elenstev@mesatop.com,
       jordan.breeding@attbi.com, maneesh@in.ibm.com, scole@lanl.gov,
       solarce@fallingsnow.net
Subject: Re: Patch: 2.5.62 devfs shrink
Message-ID: <20030226005132.GA10511@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org, alistair@devzero.co.uk,
	cloos@jhcloos.com, elenstev@mesatop.com, jordan.breeding@attbi.com,
	maneesh@in.ibm.com, scole@lanl.gov, solarce@fallingsnow.net
References: <200302251023.CAA01067@adam.yggdrasil.com> <20030225135032.7c9663da.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225135032.7c9663da.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 01:50:32PM -0800, Andrew Morton wrote:

 > diff -puN init/do_mounts.c~devfs-fix init/do_mounts.c
 > --- 25/init/do_mounts.c~devfs-fix	2003-01-16 19:39:56.000000000 -0800
 > +++ 25-akpm/init/do_mounts.c	2003-01-16 19:39:56.000000000 -0800
 > @@ -853,11 +853,6 @@ void prepare_namespace(void)
 >  {
 >  	int is_floppy;
 >  
 > -#ifdef CONFIG_DEVFS_FS
 > -	sys_mount("devfs", "/dev", "devfs", 0, NULL);
 > -	do_devfs = 1;
 > -#endif
 > -
 >  	md_run_setup();

Whoa. I thought that sucker made it into mainline.
This has been blocking closure of http://bugzilla.kernel.org/show_bug.cgi?id=110
for a while.

		Dave
