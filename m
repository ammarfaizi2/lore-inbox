Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVADAdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVADAdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVADAab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:30:31 -0500
Received: from terminus.zytor.com ([209.128.68.124]:10147 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262012AbVADAZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:25:48 -0500
Message-ID: <41D9E23A.4010608@zytor.com>
Date: Mon, 03 Jan 2005 16:24:26 -0800
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
References: <41D9C635.1090703@zytor.com>	<54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>	<41D9D65D.7050001@zytor.com> <16857.57572.25294.431752@samba.org>
In-Reply-To: <16857.57572.25294.431752@samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:
> 
> We use the following xattrs in Samba4:
> 
>  user.DosAttrib     : structure holding basic non-privileged attribute information
>  user.DosEAs        : all the DOS (OS/2) style EAs
>  user.DosStreams    : list of alternate data steams, flagged as internal or external
>  user.DosStream.name: the stream data itself for internal streams
>  security.NTACL     : the NT ACL
> 
> the rationale for making most of them in the user namespace is that it
> is 'mostly harmless' to allow the owner of the file to change those
> ones.
 >

Right, it's the "design is broken so everything ends up in user.*". 
Now, I clearly dislike the StudlyCaps used here, but if it's already 
deployed it's probably too late to fix this :(

Does Samba have any way do deal with VFAT short names?

	-hpa


