Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264335AbUEXQPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbUEXQPf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 12:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbUEXQPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 12:15:35 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:56032 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264335AbUEXQPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 12:15:33 -0400
Message-ID: <40B21F98.1080803@g-house.de>
Date: Mon, 24 May 2004 18:15:20 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6+ (Windows/20040504)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: tarballs of patchsets?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i am trying to chase some bug and i know, it must be somewhere between 2.6.4 and 
2.6.5. the 2.6.5 patch is 7.0 MB (unpacked). although i am pretty sure the lines 
starting with "diff -Nru a/Documentation" do seem to be involved with the issue, 
i am not a programmer and often have to use brute-force methods as described in 
"BUG-HUNTING". that said, i'd like to know, if there is a possibility to find 
out the different sets that generated this "patch-2.6.5.bz2".

correct me if i'm wrong, but isn't it like:
   - $scsi-maintainer sent in these patches
   - $ppc_maintainer sent in those patches
   - fix from author_x
   - more fixes from author_y

and then this whole thing is cat'ed altogether to the very patch-file.bz2?
could one compile a tar.[bz2|gz] from the patch-sets, before putting it into one 
large patch-file?

hm, maybe it's done in another way.
the thing is: even when i say: "hm, this is a ppc issue, so i'll cut out all 
diff's touching arch/ppc/ (i.e. from "$ppc_maintainer") -> the kernel might not 
compile then, and i have to wait until compilation is almost finished, just to 
find out that something under drivers/char was referencing a change in arch/ppc.

when i could know "oh, the guy who changed arch/ppc also touched drivers/char", 
i would cut out _both_ and the kernel would at least compile.

perhaps the whole process of releasing a patch is way more complex than i think 
here, but perhaps someone has some thoughts on it. just now compilation of 
2.5.6-rc1 failed. i hoped it would at least compile, because it's "only" 4MB to 
search for the bug then.

Thank you,
Christian.
-- 
BOFH excuse #9:

doppler effect
