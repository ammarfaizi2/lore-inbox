Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311552AbSCXEv1>; Sat, 23 Mar 2002 23:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311553AbSCXEvR>; Sat, 23 Mar 2002 23:51:17 -0500
Received: from air-2.osdl.org ([65.201.151.6]:39172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S311552AbSCXEvH>;
	Sat, 23 Mar 2002 23:51:07 -0500
Date: Sat, 23 Mar 2002 20:50:34 -0800 (PST)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>, <davej@suse.de>
Subject: Re: [patch 2.5] seq_file for /proc/partitions
In-Reply-To: <Pine.GSO.4.21.0203232308260.6560-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0203232049240.23956-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002, Alexander Viro wrote:

|
|
| On Sat, 23 Mar 2002 rddunlap@osdl.org wrote:
|
| > +static void *part_next(struct seq_file *part, void *v, loff_t *pos)
| > +{
| > +	++*pos;
| > +	return part_start(part, pos);
|
| Erm...  Actually that _is_ wrong - what you want is
|
| 	return ((struct gendisk)v)->next;

Yes, I see.  Thanks.

| > +}
|
| Reasons:
| 	a) just how many times do you want to grab that lock?
:)

| 	b) why bother scanning the list from the very beginning each time?
Right again.

Will repost patch after testing.

-- 
~Randy

