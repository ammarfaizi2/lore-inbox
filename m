Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWJEXQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWJEXQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWJEXQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:16:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:20241 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751432AbWJEXQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:16:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=n3XfB1PS3KhYdLOP6WAAaPlwuQ0x3lUWNJIH0r8jiPouLhTxB+ofszYNv42ctRjJuSxr16qvZNenvI/JowOQ6u1rjANnty3uADuWLIuB43t57l8hsXFFwM9YSir3ojqEqGahHZgbAbwvYAtIMnG97g+j3/SM0XjIKvKjZhzRURk=
Message-ID: <4525925C.6060807@gmail.com>
Date: Fri, 06 Oct 2006 01:16:21 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sct@redhat.com,
       adilger@clusterfs.com, ext2-devel@lists.sourceforge.net
Subject: Re: 2.6.18-mm2: ext3 BUG?
References: <45257A6C.3060804@gmail.com> <20061005145042.fd62289a.akpm@osdl.org>
In-Reply-To: <20061005145042.fd62289a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 05 Oct 2006 23:34:13 +0159
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> Hello,
>>
>> while yum update-ing, yum crashed and this appeared in log:
>> [ 2840.688718] EXT3-fs error (device hda2): ext3_free_blocks_sb: bit already 
>> cleared for block 747938
>> [ 2840.688732] Aborting journal on device hda2.
>> [ 2840.688858] ext3_abort called.
>>
>> ...
>>
>> I don't know how to reproduce it and really have no idea what version of -mm 
>> could introduce it (if any).
> 
> I don't necessarily see a bug in there.  The filesystem got a bit noisy but
> did appropriately detect and handle the metadata inconsistency.

Perhaps, but why did it occur? S.m.a.r.t. doesn't tell me anything suspicious.

> The next step would be to fsck that filesystem, see waht it says.

Yup. I fscked it after reboot and fixed them all...

[went to gather some info from e2fsprogs sources what kind of errors it was (I 
didn't note it and can't remember)]

block differences, incorrect block counts, orphaned entries, some (gnome-vfs2 
stuff which has been updated) went to lost+found.

I unfotunately can't post more accurate info, because I am a... chump? Bite me 
and shame on me...

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
