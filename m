Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUIDSwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUIDSwL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 14:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUIDSwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 14:52:11 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:42605 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265701AbUIDSwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 14:52:08 -0400
Message-ID: <413A0EEE.4000007@cs.aau.dk>
Date: Sat, 04 Sep 2004 20:52:30 +0200
From: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
References: <41385FA5.806@cs.aau.dk> <20040903133238.A4145@infradead.org> <413865B4.7080208@cs.aau.dk> <20040903140449.A4253@infradead.org> <41386FB7.2060804@cs.aau.dk> <20040903150111.A4884@infradead.org> <4138CBEF.9000909@cs.aau.dk> <20040904120958.B14123@infradead.org>
In-Reply-To: <20040904120958.B14123@infradead.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Sep 03, 2004 at 09:54:23PM +0200, Kristian Sørensen wrote:
> 
>>>>We are working on a project called Umbrella, (umbrella.sf.net) which 
>>>>implements processbased mandatory accesscontrol in the Linux kernel. 
>>>>This access control is controlled by "restriction", e.g. by restricting 
>>>> some process from accessing any given file or directory.
>>>>
>>>>E.g. if a root owned process is restricted from accessing /var/www, and 
>>>>the process is compromised by an attacker, no mater what he does, he 
>>>>would not be able to access this directory.
>>>
>>>
>>>mount --bind /var/www /home/joe/p0rn/, and then?
>>
>>Actually this "attack" is avoided, because restrictions are enherited, 
>>from parent proces to its children.
> 
> 
> If you restrict your process on the path /var/ww/ but the same objects
> are also available below a different path, what does that have to do with
> child processes?
Well nothing :-) The point was, that links and mount bindings are 
handled, and if the parent is restricted from accessing a file, the 
child is too.

KS.
