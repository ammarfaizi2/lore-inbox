Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269660AbUICMkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269660AbUICMkp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUICMir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:38:47 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:42704 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S269693AbUICMiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:38:13 -0400
Message-ID: <413865B4.7080208@cs.aau.dk>
Date: Fri, 03 Sep 2004 14:38:12 +0200
From: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040619)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: umbrella-devel@lists.sourceforge.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
References: <41385FA5.806@cs.aau.dk> <20040903133238.A4145@infradead.org>
In-Reply-To: <20040903133238.A4145@infradead.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph!

Christoph Hellwig wrote:
> On Fri, Sep 03, 2004 at 02:12:21PM +0200, Kristian Sørensen wrote:
> 
>>I have a short question, concerning how to get the full path of a file 
>>from a LSM hook.
>>
>>- If the "file" of the dentry is located in the root filesystem: no
>>   problem - simply traverse the dentrys, to generate the path.
>>
>>- If the "file" is mounted from another partition, you do not get the
>>   full path by traversing the dentrys.
> 
> 
> There is no canonical full path for a given dentry.
Is there another way to get it? We also get an inodepointer from the LSM 
hook. As far as I know, the file struct has an entry called vfs_mount, 
which has an entry called root_mnt - could this be used? (and if so, how 
do I get from the Inode to the file struct? :-/ )


KS.
