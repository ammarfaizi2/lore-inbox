Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVADBtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVADBtw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 20:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVADBtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 20:49:52 -0500
Received: from terminus.zytor.com ([209.128.68.124]:35753 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261940AbVADBtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 20:49:50 -0500
Message-ID: <41D9F5FB.7080204@zytor.com>
Date: Mon, 03 Jan 2005 17:48:43 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicholas Miell <nmiell@comcast.net>
CC: tridge@samba.org, Michael B Allen <mba2000@ioplex.com>, sfrench@samba.org,
       linux-ntfs-dev@lists.sourceforge.net, samba-technical@lists.samba.org,
       aia21@cantab.net, hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
References: <41D9C635.1090703@zytor.com>	 <54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>	 <41D9D65D.7050001@zytor.com> <16857.57572.25294.431752@samba.org>	 <41D9E23A.4010608@zytor.com> <1104802319.3604.71.camel@localhost.localdomain>
In-Reply-To: <1104802319.3604.71.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell wrote:
> 
> The design isn't broken, you're just missing an important detail of what
> the system namespace entails:
> 
> xattrs in the system namespace have a format defined by the kernel and
> (more importantly -- this is the important detail) modify kernel
> behavior.
> 
> If the xattr namespace was flat, I would have no way of knowing whether
> or not the kernel will set the Archived bit in fatattrs (or DosAttrib)
> xattr when I write to a file that has that xattr or whether or not the
> kernel will choose to enforce the ACL I store in the posix_acl_access
> xattr.
> 
> With the system namespace, I can rely on the fact that xattrs in that
> namespace actually have a meaning and are in sync with what the kernel
> believes to be true about the file.
> 

What you're neglecting is that there is a LARGE class of metadata where 
the important thing is that you store them; if you don't know what they 
are you merely ignore them and keep them as-is.

There is no place for those in the current design.

	-hpa
