Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVADBb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVADBb2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 20:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVADBb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 20:31:28 -0500
Received: from terminus.zytor.com ([209.128.68.124]:40360 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261937AbVADBb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 20:31:26 -0500
Message-ID: <41D9F1C4.6000902@zytor.com>
Date: Mon, 03 Jan 2005 17:30:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tridge@samba.org
CC: Michael B Allen <mba2000@ioplex.com>, sfrench@samba.org,
       linux-ntfs-dev@lists.sourceforge.net, samba-technical@lists.samba.org,
       aia21@cantab.net, hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
References: <41D9C635.1090703@zytor.com>	<54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com> <16857.61339.370059.16758@samba.org>
In-Reply-To: <16857.61339.370059.16758@samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:
> Mike,
> 
>  > If we're just thinking about MS-oriented discretionary access control then
>  > I think the owner of the file is basically king and should be the only
>  > normal user to that can read and write it's xattrs. So whatever namespace
>  > that is (not system).
> 
> for the DACL the owner is king (the owner gets the WRITE_DAC,
> READ_CONTROL and STD_DELETE access bits forced on), but for the other
> parts of the full security descriptor this is not true. The owner
> doesn't get to arbitrarily write to the owner_sid or SACL. Thats why I
> used security.NTACL not user.NTACL.
> 
> I suppose we could have a separate user.DACL attribute, but given that
> there is just one API that sets all 4 elements of the SD (with a
> bitmask to say which bits to set), it made more sense to me to group
> them all together. The disadvantage is that Samba needs to gain/lose
> root privileges for the "set SD" call even if the client is only
> asking to set the DACL.
> 

Even more so a reason for this not to be a general API.

	-hpa

