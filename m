Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVADEF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVADEF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 23:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVADEF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 23:05:27 -0500
Received: from li4-142.members.linode.com ([66.220.1.142]:9482 "EHLO
	li4-142.members.linode.com") by vger.kernel.org with ESMTP
	id S262013AbVADEFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:05:23 -0500
Message-ID: <27793.199.43.32.68.1104811520.squirrel@li4-142.members.linode.com>
In-Reply-To: <41D9E3AA.5050903@zytor.com>
References: <41D9C635.1090703@zytor.com>
    <16857.56805.501880.446082@samba.org> <41D9E3AA.5050903@zytor.com>
Date: Mon, 3 Jan 2005 23:05:20 -0500 (EST)
Subject: Re: FAT, NTFS, CIFS and DOS attributes
From: "Michael B Allen" <mba2000@ioplex.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: tridge@samba.org, sfrench@samba.org, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, samba-technical@lists.samba.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       hirofumi@mail.parknet.co.jp
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin said:
> In other words, I'm inclined to define simple system attributes or just
> go back to the original ioctl() patch for the DOS filesystems as seen by
> the kernel.

Well if you're just interested in DOS attributes you don't care about how
Samba handles ACLs. You're only interested in about 3 bits. Anyway I have
an idea...

If the attrib member in xattr_DosInfo2 was moved to the beginning of the
structure the all attrib members would always be encoded at the same
offset within the data returned by getxattr regardless of what info
strucutre was used. So you could get and set these attributes as
user.DosAttrib in a fairly compatible way.

Mike
