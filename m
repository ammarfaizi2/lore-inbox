Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWAaBm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWAaBm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 20:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWAaBm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 20:42:59 -0500
Received: from terminus.zytor.com ([192.83.249.54]:55787 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030258AbWAaBm6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 20:42:58 -0500
Message-ID: <43DEC095.2090507@zytor.com>
Date: Mon, 30 Jan 2006 17:42:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: Exporting which partitions to md-configure
References: <43DEB4B8.5040607@zytor.com> <17374.47368.715991.422607@cse.unsw.edu.au>
In-Reply-To: <17374.47368.715991.422607@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Monday January 30, hpa@zytor.com wrote:
> 
>>Any feeling how best to do that?  My current thinking is to export a 
>>"flags" entry in addition to the current ones, presumably based on 
>>"struct parsed_partitions->parts[].flags" (fs/partitions/check.h), which 
>>seems to be what causes md_autodetect_dev() to be called.
> 
> I think I would prefer a 'type' attribute in each partition that
> records the 'type' from the partition table.  This might be more
> generally useful than just for md.
> Then your userspace code would have to look for '253' and use just
> those partitions.
> 

What about non-DOS partitions?

	-hpa
