Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVADBKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVADBKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 20:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVADBDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 20:03:06 -0500
Received: from terminus.zytor.com ([209.128.68.124]:49062 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261471AbVADA6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:58:33 -0500
Message-ID: <41D9EA09.8010302@zytor.com>
Date: Mon, 03 Jan 2005 16:57:45 -0800
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
References: <41D9C635.1090703@zytor.com>	<54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>	<41D9D65D.7050001@zytor.com>	<16857.57572.25294.431752@samba.org>	<41D9E23A.4010608@zytor.com> <16857.58819.311223.845400@samba.org>
In-Reply-To: <16857.58819.311223.845400@samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:
>  > Right, it's the "design is broken so everything ends up in user.*". 
>  > Now, I clearly dislike the StudlyCaps used here, but if it's already 
>  > deployed it's probably too late to fix this :(
> 
> Samba4 is only deployed by a very few brave sites (such as my wifes
> server) who all know that things might change in non-compatible
> ways. Still, I'd want a slightly stronger reason than dislike of
> studly caps to change it :-)
> 

The slightly stronger reason is basically the same reason why we don't 
stuff a bunch of things into a struct stat and call a single system call 
to change a bunch of attributes; you don't want to have to change them 
all every time, and by putting them all in the same structure that's 
your only option, since setxattr() doesn't allow you to mask and merge.

Incidentally, the document you pointed me to wasn't clear on the 
endianness convention.

	-hpa
