Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288761AbSAIDaZ>; Tue, 8 Jan 2002 22:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288762AbSAIDaP>; Tue, 8 Jan 2002 22:30:15 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:57259 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288761AbSAIDaA>; Tue, 8 Jan 2002 22:30:00 -0500
Date: Tue, 8 Jan 2002 20:30:11 -0700
Message-Id: <200201090330.g093UB427696@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <a1gcme$18t$1@cesium.transmeta.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>
	<20020108201451.088f7f99.rusty@rustcorp.com.au>
	<a1f9j9$5i9$1@cesium.transmeta.com>
	<20020109120108.39bcf7ad.rusty@rustcorp.com.au>
	<a1gcme$18t$1@cesium.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> By author:    Rusty Russell <rusty@rustcorp.com.au>
> > Incorrect.  See my new /proc/sys implementation patch.  It's hidden in the
> > flames somewhere...
> > 
> 
> So you chown an entry, then a module is unloaded and reloaded, now
> what happens?
> 
> It's the old "virtual filesystem which really wants persistence"
> issue again...

Works beautifully with devfs+devfsd :-)

Permissions get saved elsewhere in the namespace (perhaps even to the
underlying /dev) as you chown(2)/chmod(2)/mknod(2), and are restored
when entries are (re)created and/or at startup.

My /dev has persistence behaviour which looks like a FS with backing
store.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
