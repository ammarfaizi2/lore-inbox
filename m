Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317977AbSHZVso>; Mon, 26 Aug 2002 17:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318148AbSHZVso>; Mon, 26 Aug 2002 17:48:44 -0400
Received: from soul.math.tau.ac.il ([132.67.192.131]:36748 "EHLO tau.ac.il")
	by vger.kernel.org with ESMTP id <S317977AbSHZVsn>;
	Mon, 26 Aug 2002 17:48:43 -0400
Date: Tue, 27 Aug 2002 00:52:54 +0300
From: Yedidyah Bar-David <didi@tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: updating the partition table of a busy drive
Message-ID: <20020827005254.A20617@soul.math.tau.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Currently, any change to a partition table of a busy drive is
practically delayed to the next reboot. Even things trivial as
changing the type of an unmounted partition do not work, if
another partition on that drive is mounted (or swapped to, etc.).

Is this really unavoidable? Of course, generally, this is
dangerous: E.g., deleting a logical partition (in a PC-BIOS
scheme) can change the numbers of other partitions. But the test
currently seems very conservative. I haven't yet looked too much
at the code, but I think a slightly less conservative test (that
will still not update in many situations, but will allow trivial
things like adding a primary partition), will not be too hard.
Is such a thing needed by others, or is it just me? Suppose I
write an initial patch, are there interested beta testers?

On a side note, about a year and a half ago, there was a thread
on lkml with the subject 'Partition IDs in the New World TM', in
which a 'parttab' file was mentioned. I grepped and STFWed a lot,
and could not find any relevant mention anywhere, besides this
thread. Is this parttab implemented? Documented? Perhaps under
a different name? Is this case it is quite hard to find
(google search for 'linux parttab' has 37 results, but for
e.g. 'linux partition table initrd' 11400 results).

Please CC me as I am not subscribed to lkml.

Thanks,

	Didi

