Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTDSSyx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 14:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263437AbTDSSyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 14:54:53 -0400
Received: from ca-fulrtn-cuda2-c6a-113.anhmca.adelphia.net ([68.66.9.113]:12160
	"EHLO shrike.mirai.cx") by vger.kernel.org with ESMTP
	id S263436AbTDSSyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 14:54:52 -0400
Message-ID: <3EA19E4B.7000201@tmsusa.com>
Date: Sat, 19 Apr 2003 12:06:51 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: recent rwhod woes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, just a reminder that rwhod is broken in recent 2.5.67-xx kernels.

I had earlier reported it incorrectly, saying I first saw the problem
in 2.5.67-mm3, but going back to verify, I see that 2.5.67-mm1 is OK
while 2.5.67-mm2 through -mm4 are broken.

I noticed that rwhod is OK in 2.5.67 + linux patchset 1.1177, but
adding the sk-allocation patch (from -mm2) breaks rwhod.

The symptom here is that running the "ruptime" command on an -mm2
box shows all hosts down - however the other hosts on the subnet are
getting the rwho broadcasts from the -mm2 box, but the -mm2 box is
unable to process rwho broadcasts, including it's own -

I'd hoped I could narrow it down to that patch, but backing out that
single patch does not fix -mm2 through -mm4, so it appears that while
the one patch will break rwhod, there are apparently other changes
that also break rwhod independently of the sk-allocation patch, and
the answer is more involved than I'd hoped.

I've been hammered at work lately so time is limited, but I did want
to raise the rwhod issue again - if I get some time I'll check the
plain -bk tree, or if someone has any ideas I'll be happy to act as
a patch & test monkey in my spare time.

Best Regards,

Joe


