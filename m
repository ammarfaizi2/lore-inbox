Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVL1C5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVL1C5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 21:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVL1C5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 21:57:42 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:17261 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932394AbVL1C5m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 21:57:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UyKd/ctoV0e3ChtW/aBufNeEU0EtdL8vkeUG8HPQjOOjKLw/PAfJGn+tZYQvLxTMXjfBMyPyG9M0GtN97Dra0V6UnWjYtf3oSlY55+kfIS1edCq4hTGVrmWu+jjOE7GFZEGKvpD4l7+JNEWL4G2joY6DSrK9fja/guMTk8zgsC0=
Message-ID: <9e4733910512271857v41f61535g91ebcb87664e7f7c@mail.gmail.com>
Date: Tue, 27 Dec 2005 21:57:41 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: monitoring directory trees with iNotify
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has a directory tree monitoring mode been considered for iNotify? It
seems likely to me that anyone using this API probably needs to
monitor whole trees.

With the current API there seems to be race conditions around
directory creation/deletion and the queue overflowing. For example if
a new directory is created you are in a race with the creating program
to get a watch on that directory before things start happening in it.
A tree based watch would eliminate this problem.

I'd also find a mode where the events returned full paths instead of
watch ids useful too. With the current model I have to cache the
entire directory tree in my app to associate the watch ids with the
path to each directory. If the path came back with the event I could
eliminate the shadow tree.

--
Jon Smirl
jonsmirl@gmail.com
