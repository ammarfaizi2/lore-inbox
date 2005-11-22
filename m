Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVKWPwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVKWPwB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVKWPvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:51:08 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:15779 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751146AbVKWPul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:50:41 -0500
Message-ID: <43838A49.9010804@tmr.com>
Date: Tue, 22 Nov 2005 16:14:49 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Chris Adams <cmadams@hiwaay.net>, linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no> <20051122161712.GA942598@hiwaay.net> <Pine.LNX.4.64.0511221650360.2763@hermes-1.csi.cam.ac.uk> <20051122171847.GD31823@thunk.org> <Pine.LNX.4.64.0511221921530.7002@hermes-1.csi.cam.ac.uk> <20051122195201.GG31823@thunk.org>
In-Reply-To: <20051122195201.GG31823@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Tue, Nov 22, 2005 at 07:25:20PM +0000, Anton Altaparmakov wrote:
> 
>>>>The standards are insufficient however.  For example dealing with named 
>>>>streams or extended attributes if exposed as "normal files" would 
>>>>naturally have the same st_ino (given they are the same inode as the 
>>>>normal file data) and st_dev fields.
>>>
>>>Um, but that's why even Solaris's openat(2) proposal doesn't expose
>>>streams or extended attributes as "normal files".  The answer is that
>>>you can't just expose named streams or extended attributes as "normal
>>>files" without screwing yourself.
>>
>>Reiser4 does I believe...
> 
> 
> Reiser4 violates POSIX.  News at 11....
> 
> 
>>I was not talking about Solaris/UFS.  NTFS has named streams and extended 
>>attributes and both are stored as separate attribute records inside the 
>>same inode as the data attribute.  (A bit simplified as multiple inodes 
>>can be in use for one "file" when an inode's attributes become large than 
>>an inode - in that case attributes are either moved whole to a new inode 
>>and/or are chopped up in bits and each bit goes to a different inode.)
> 
> 
> NTFS violates POSIX.  News at 11....
> 
True, but perhaps in this case it's time for POSIX to move, the things 
in filesystems, and which are used as filesystems have changed a bunch.

It would be nice to have a neutral standard rather than adopting 
existing extended implementations, just because the politics of it are 
that everyone but MS would hate NTFS, MS would hate any of the existing 
others, and a new standard would have the same impact on everyone and 
therefore might be viable. Not a quick fix, however, standards take a 
LONG time.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

