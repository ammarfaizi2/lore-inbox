Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbUCYD2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 22:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbUCYD2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 22:28:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:23173 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263138AbUCYD2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 22:28:53 -0500
Subject: Re: swsusp with highmem, testing wanted
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
In-Reply-To: <20040324235702.GA497@elf.ucw.cz>
References: <20040324235702.GA497@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1080185300.1147.62.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 25 Mar 2004 14:28:20 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-25 at 10:57, Pavel Machek wrote:
> Hi!
> 
> If you have machine with >=1GB of RAM, do you think you could test
> this patch? [I'd like to hear about successes, too; perhaps send it
> privately].

Ugh ? If I understand things properly, you are copying all of highmem
down to lowmem ? Hrm... I'm afraid in lots of case you'll run out
of lowmem in the process. Actually, we should be able to use highmem
even for snapshotting since the disk IO can then be directly be done
from highmem pages...

(Though kmapp'ing/unmapping each page will be slow as hell)

Ben.


