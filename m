Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbUKUGLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbUKUGLd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 01:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbUKUGLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 01:11:32 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:24027 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261797AbUKUGLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 01:11:30 -0500
Message-ID: <41A0319B.7060803@namesys.com>
Date: Sat, 20 Nov 2004 22:11:39 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tridge@samba.org
CC: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: performance of filesystem xattrs with Samba4
References: <16797.41728.984065.479474@samba.org>	<419E1297.4080400@namesys.com>	<16798.31565.306237.930372@samba.org>	<419ECAB5.10203@namesys.com>	<16798.59519.63931.494579@samba.org>	<419F6D1F.10001@namesys.com>	<16799.62734.463565.38876@samba.org>	<41A00205.1020704@namesys.com> <16800.2371.421108.693783@samba.org>
In-Reply-To: <16800.2371.421108.693783@samba.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:

>
>So while I sympathise with you wanting reiser4 to be tuned for "big"
>storage, please remember that a good proportion of the installs are
>likely to be running "in-memory" workloads.
>  
>
I agree that in-memory workloads are important, and that is why we 
compress on flush rather than compressing on write for our compression 
plugin, and it is why we should spend some time optimizing reiser4 to 
make its code paths more lightweight for the in-memory case.  At the 
same time, I think that the workloads where the filesystem matters the 
most are the ones that access the disk.  With computers, in a large 
percentage of the time that people notice themselves waiting, it is the 
disk drive they are waiting on.

Sigh, there are so many things we should optimize for, and it will be 
years before we have hit all the important ones.
