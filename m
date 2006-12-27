Return-Path: <linux-kernel-owner+w=401wt.eu-S932889AbWL0Cpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbWL0Cpj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 21:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932892AbWL0Cpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 21:45:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:51875 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932889AbWL0Cpi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 21:45:38 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: util-linux: orphan
Date: Wed, 27 Dec 2006 03:46:10 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Henne Vogelsang <hvogel@suse.de>,
       Olaf Hering <olh@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
References: <20061109224157.GH4324@petra.dvoda.cz> <20061218071737.GA5217@petra.dvoda.cz>
In-Reply-To: <20061218071737.GA5217@petra.dvoda.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612270346.10699.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 08:17, Karel Zak wrote:
>         - remove FS/device detection code
>           (libblkid from e2fsprogs or libvolumeid is replacement)

I saw that the current Fedora already dynamically links /bin/mount
against /usr/lib/libblkid.so. This obviously does not work if
/usr is a separate partition that needs to be mounted with /bin/mount.
I also had problems with selinux claiming I had no right to access
libblkid, which meant that the root fs could not be remounted r/w.

I'd suggest that you make sure that mount always gets statically linked
against libblkid to avoid these problems.

	Arnd <><
