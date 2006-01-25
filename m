Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWAYQ4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWAYQ4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 11:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWAYQ4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 11:56:18 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:56864 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750925AbWAYQ4S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 11:56:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WAhUcrL9ziUoFkRmZuqyyr1wDijZdFVIdz/MchCS6rL8M5+v4TGeb/XDdZVWr7Inm/Bstx1LWR6ysXkyd8DRImkzeSmPhL1d9GFeH6wUSuv1F9cee5OAqAH/vncIFMurLRR15HAOhi6cGNHGPlvSDKdzpkn9gawl6mL7u+qtCdI=
Message-ID: <7f45d9390601250856n4adbdf1dvb967545155f0e341@mail.gmail.com>
Date: Wed, 25 Jan 2006 09:56:16 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Replaying a list of blocks into the cache (BootCache)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm attempting to speed up the boot of an embedded system. I've found
that forcing certain key shared libraries to cache early by copying
them from the file system to a tmpfs early in the boot made a big
difference -- on the order of twenty seconds. I'm not even accessing
these shared libraries from the tmpfs; I'm just using this trick to
make sure the libraries stay in memory. Seeing what a big difference
this simple trick made, I wanted to see what else I could accomplish
by making use of the file system cache.

This made me think of the OS X BootCache feature, which saves the list
of disk  blocks accessed during the boot sequence and replays that
list on the next boot. Is there anything like this in Linux?

Please cc me in your reply. Thanks!
Shaun
