Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262228AbTCRNph>; Tue, 18 Mar 2003 08:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262382AbTCRNph>; Tue, 18 Mar 2003 08:45:37 -0500
Received: from camus.xss.co.at ([194.152.162.19]:48137 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S262228AbTCRNpg>;
	Tue, 18 Mar 2003 08:45:36 -0500
Message-ID: <3E772581.8080501@xss.co.at>
Date: Tue, 18 Mar 2003 14:56:17 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.65-mm1 small nfs umount problem, also in 64-mm8
References: <20030318031104.13fb34cc.akpm@digeo.com> <3E771F24.40508@aitel.hist.no>
In-Reply-To: <3E771F24.40508@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Helge Hafting wrote:
> 
> I have some nfs mounts that users are allowed to mount.
> That works, but the user can't umount. "Only root can umount..."
> I believe the user doing the mount were allowed to umount before.
> 
Did you upgrade your util-linux package recently and do
you have /etc/mtab symlinked to /proc/mounts?

I noticed a similar problem (with user-mountable CD-ROM
devices and linux-kernel v2.2) and found a change in
util-linux/mount/umount.c which might be responsible for
it. If so, it is IMHO not a kernel issue, anyway

I didn't have the time to further examine the problem yet,
though...

HTH

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71

