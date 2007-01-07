Return-Path: <linux-kernel-owner+w=401wt.eu-S964801AbXAGSZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbXAGSZl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 13:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbXAGSZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 13:25:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:62152 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964801AbXAGSZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 13:25:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pFyOAdv1ZbGPyISkCeQ00fkq+0nmrRVgdunBoH9XOr5WSOmWc7929GUMWR9TVKpxTUF+bdApaH6on/czh2PzzwdMaCx6fVJ0mCyILTJee5qpbKb3+v4KqM1ZaJMfjqIGi979NAledZaN6ObTS1Fk+0ZrXjDtkrLxiV/aiPnmsHM=
Message-ID: <d092c2300701071025i16f11c50p3908c1d8427ab3b4@mail.gmail.com>
Date: Sun, 7 Jan 2007 13:25:38 -0500
From: "Johnicholas Hines" <johnicholas.hines@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: a lttng success story
Cc: ltt-dev@shafik.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I was really pleased to find an intermittent timing problem using
lttng, and maybe an example of how it can be used would be helpful to
people considering adopting it.

The system is a veterinary testing machine running Linux on an ARM
board (specifically the applied data systems sphere).

The symptom was that, under a certain workload, intermittently, a
timing constraint was being violated. Setting the processes to debug
mode (spitting out lots of messages) was too slow - many timing
constraints were violated, and the workload was unrunnable.

I ran the bug-revealing workload under lttng for 4 hours, and captured
one abnormal event (and thousands of normal events). I waded through
the lttng logs, and found that the reason for the pause was that the
target of a message had, in the abnormal case, not blocked on that fd.

Lttng reveals things about the state of the scheduler that are very
helpful in debugging multi-process, userspace, systems. It is faster
and reveals more information than anything special-purpose I could
have built. To repeat myself, maybe an example of how it can be used
would be helpful to people considering adopting it.


Thanks for your attention,

Johnicholas
