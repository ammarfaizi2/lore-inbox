Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270007AbTGUMs4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270013AbTGUMs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:48:56 -0400
Received: from pushme.nist.gov ([129.6.16.92]:18577 "EHLO postmark.nist.gov")
	by vger.kernel.org with ESMTP id S270007AbTGUMsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:48:52 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 - device_suspend KERN_EMERG message?
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Mon, 21 Jul 2003 09:03:48 -0400
Message-ID: <9cffzl0nia3.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any special reason to scream that we're suspending devices in
device_suspend?

int device_suspend(u32 state, u32 level)
{
        struct device * dev;
        int error = 0;

        printk(KERN_EMERG "Suspending devices\n");

...

And likewise further below during resume.

On my box, syslog shouts to all xterms and KDE throws up a kwrite message
too.  Why is this an emergency?  If there are no objections, I'll send
a patch to move these messages to KERN_NOTICE.

Ian

