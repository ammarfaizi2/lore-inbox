Return-Path: <linux-kernel-owner+w=401wt.eu-S1753580AbWL0SPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbWL0SPa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 13:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753610AbWL0SPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 13:15:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40006 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbWL0SP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 13:15:29 -0500
Date: Wed, 27 Dec 2006 19:15:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Henne Vogelsang <hvogel@suse.de>,
       Olaf Hering <olh@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: util-linux: orphan
Message-ID: <20061227181510.GB17785@petra.dvoda.cz>
References: <20061109224157.GH4324@petra.dvoda.cz> <20061218071737.GA5217@petra.dvoda.cz> <200612270346.10699.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200612270346.10699.arnd@arndb.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 03:46:10AM +0100, Arnd Bergmann wrote:
> On Monday 18 December 2006 08:17, Karel Zak wrote:
> >         - remove FS/device detection code
> >           (libblkid from e2fsprogs or libvolumeid is replacement)
> 
> I saw that the current Fedora already dynamically links /bin/mount
> against /usr/lib/libblkid.so. 

 Sorry, but it's nonsense.

 $ grep -r %{_root_libdir}/libblkid.so *

 devel/e2fsprogs.spec:%{_root_libdir}/libblkid.so.*
 FC-1/e2fsprogs.spec:%{_root_libdir}/libblkid.so.*
 FC-2/e2fsprogs.spec:%{_root_libdir}/libblkid.so.*
 FC-3/e2fsprogs.spec:%{_root_libdir}/libblkid.so.*
 FC-4/e2fsprogs.spec:%{_root_libdir}/libblkid.so.*
 FC-5/e2fsprogs.spec:%{_root_libdir}/libblkid.so.*
 FC-5/e2fsprogs.spec~:%{_root_libdir}/libblkid.so.*
 FC-6/e2fsprogs.spec:%{_root_libdir}/libblkid.so.*
 RHEL-4/e2fsprogs.spec:%{_root_libdir}/libblkid.so.*
 RHEL-5/e2fsprogs.spec:%{_root_libdir}/libblkid.so.*
 
 (where %{_root_libdir} = /lib)

> This obviously does not work if /usr is a separate partition that
> needs to be mounted with /bin/mount.

 Yes, I have /usr on a separate partition for many years :-)

> I'd suggest that you make sure that mount always gets statically linked
> against libblkid to avoid these problems.

 It's dynamically linked in many distributions without a problem.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
