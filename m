Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVACXgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVACXgm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVACXgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:36:05 -0500
Received: from terminus.zytor.com ([209.128.68.124]:11169 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261972AbVACXe3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:34:29 -0500
Message-ID: <41D9D65D.7050001@zytor.com>
Date: Mon, 03 Jan 2005 15:33:49 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael B Allen <mba2000@ioplex.com>
CC: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
References: <41D9C635.1090703@zytor.com> <54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>
In-Reply-To: <54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael B Allen wrote:
> 
>>b) if xattr is the right thing, shouldn't this be in the system
>>namespace rather than the user namespace?
> 
> If we're just thinking about MS-oriented discretionary access control then
> I think the owner of the file is basically king and should be the only
> normal user to that can read and write it's xattrs. So whatever namespace
> that is (not system).
> 

system namespace means that it's a name defined by the kernel as opposed 
to a name defined by the user.  One of the most glaring design errors in 
this whole thing, in my opinion, but if we're going to use xattrs we 
probably should stick with it.

Thus, I'd propose:

	system.dosattrib	- DOS attributes (single byte)
	system.dosshortname	- DOS short name (e.g. for VFAT)

	-hpa
