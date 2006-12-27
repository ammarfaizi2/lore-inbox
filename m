Return-Path: <linux-kernel-owner+w=401wt.eu-S932898AbWL0D7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbWL0D7O (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 22:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932899AbWL0D7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 22:59:14 -0500
Received: from moutng.kundenserver.de ([212.227.126.179]:57306 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932898AbWL0D7N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 22:59:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: util-linux: orphan
Date: Wed, 27 Dec 2006 04:58:54 +0100
User-Agent: KMail/1.9.5
Cc: Karel Zak <kzak@redhat.com>, linux-kernel@vger.kernel.org,
       Henne Vogelsang <hvogel@suse.de>, Olaf Hering <olh@suse.de>
References: <20061109224157.GH4324@petra.dvoda.cz> <200612270346.10699.arnd@arndb.de> <4591E3BB.9070806@zytor.com>
In-Reply-To: <4591E3BB.9070806@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612270458.55790.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 04:08, H. Peter Anvin wrote:
> 
> > I'd suggest that you make sure that mount always gets statically linked
> > against libblkid to avoid these problems.
> > 
> 
> That's a pretty silly statement.  The real issue is that any library 
> needed by binaries in /bin or /sbin should live in /lib, not /usr/lib.

Right, this is obviously true in general. I don't understand enough
about selinux (who does?) to be sure what went wrong there on top
of this, but my impression was that I could have solved the problem
if I had been able to remount the root partition, or mount the selinux
file system, which was made impossible by the fact that I had no
permission to access one of the libraries for the mount binary.

The location of the library file was not the problem I had, as that
system doesn't have a separate /usr partition. 

	Arnd <><
