Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVACXuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVACXuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVACXuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:50:32 -0500
Received: from li4-142.members.linode.com ([66.220.1.142]:60680 "EHLO
	li4-142.members.linode.com") by vger.kernel.org with ESMTP
	id S261985AbVACXsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:48:42 -0500
Message-ID: <53299.199.43.32.68.1104796121.squirrel@li4-142.members.linode.com>
In-Reply-To: <41D9D65D.7050001@zytor.com>
References: <41D9C635.1090703@zytor.com>
    <54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>
    <41D9D65D.7050001@zytor.com>
Date: Mon, 3 Jan 2005 18:48:41 -0500 (EST)
Subject: Re: FAT, NTFS, CIFS and DOS attributes
From: "Michael B Allen" <mba2000@ioplex.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin said:
> Michael B Allen wrote:
>>
>>>b) if xattr is the right thing, shouldn't this be in the system
>>>namespace rather than the user namespace?
>>
>> If we're just thinking about MS-oriented discretionary access control
>> then
>> I think the owner of the file is basically king and should be the only
>> normal user to that can read and write it's xattrs. So whatever
>> namespace
>> that is (not system).
>>
>
> system namespace means that it's a name defined by the kernel as opposed
> to a name defined by the user.  One of the most glaring design errors in
> this whole thing, in my opinion, but if we're going to use xattrs we
> probably should stick with it.
>
> Thus, I'd propose:
>
> 	system.dosattrib	- DOS attributes (single byte)
> 	system.dosshortname	- DOS short name (e.g. for VFAT)

Oh, from the man page I thought 'system' attributes were "extended
attributes to which ordinary processes should not have access". Is that
not true? If it is true, how would an ordinary user change these attrs?

Mike
