Return-Path: <linux-kernel-owner+w=401wt.eu-S932892AbWL0DJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892AbWL0DJH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 22:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWL0DJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 22:09:07 -0500
Received: from terminus.zytor.com ([192.83.249.54]:54190 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932892AbWL0DJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 22:09:06 -0500
Message-ID: <4591E3BB.9070806@zytor.com>
Date: Tue, 26 Dec 2006 19:08:43 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Karel Zak <kzak@redhat.com>, linux-kernel@vger.kernel.org,
       Henne Vogelsang <hvogel@suse.de>, Olaf Hering <olh@suse.de>
Subject: Re: util-linux: orphan
References: <20061109224157.GH4324@petra.dvoda.cz> <20061218071737.GA5217@petra.dvoda.cz> <200612270346.10699.arnd@arndb.de>
In-Reply-To: <200612270346.10699.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Monday 18 December 2006 08:17, Karel Zak wrote:
>>         - remove FS/device detection code
>>           (libblkid from e2fsprogs or libvolumeid is replacement)
> 
> I saw that the current Fedora already dynamically links /bin/mount
> against /usr/lib/libblkid.so. This obviously does not work if
> /usr is a separate partition that needs to be mounted with /bin/mount.
> I also had problems with selinux claiming I had no right to access
> libblkid, which meant that the root fs could not be remounted r/w.
> 
> I'd suggest that you make sure that mount always gets statically linked
> against libblkid to avoid these problems.
> 

That's a pretty silly statement.  The real issue is that any library 
needed by binaries in /bin or /sbin should live in /lib, not /usr/lib.

	-hpa
