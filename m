Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbTKQNxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 08:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTKQNxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 08:53:48 -0500
Received: from web20704.mail.yahoo.com ([216.136.226.177]:5255 "HELO
	web20704.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263517AbTKQNxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 08:53:47 -0500
Message-ID: <20031117094551.53765.qmail@web20704.mail.yahoo.com>
Date: Mon, 17 Nov 2003 01:45:51 -0800 (PST)
From: kernwek jalsl <edityacomm@yahoo.com>
Subject: softirqd
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All;

On my embedded board I see that the preemption
patch(Love etal.) is not of much use because of the
following reaons:

1) calling the scheduler after the hardirq returns is
not of much use because the actual work of puting the
task in the run queue is done in the bottom half
executed by ksoftirqd
2) ksoftirqd is not a real time thread

Will the preemption patch work better if the ksoftirqd
is made a real time thread?

Another related question : has anyone thought of
introducing prioirty among tasklets? Right now
ksoftirqd treats them in a FIFO manner. Adding
priority among the various tasklets and making sure
that ksoftirqd looks ahead in the queue would ensure a
real time treatment to a real time interrupt...

I am sorry in case this has been discussed earlier; in
case it has been I would like someone to post me the
URl for the discussion.

Regards

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
