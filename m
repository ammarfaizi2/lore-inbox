Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265718AbUA0AXG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbUA0AXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:23:06 -0500
Received: from mail.tmr.com ([216.238.38.203]:36874 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265718AbUA0AV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:21:26 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Is there a way to keep the 2.6 kjournald from writing to idle disks? (to allow spin-downs)
Date: 27 Jan 2004 00:21:09 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bv4atl$77d$1@gatekeeper.tmr.com>
References: <40140B0A.90707@isg.de> <20040125205219.GE26600@luna.mooo.com>
X-Trace: gatekeeper.tmr.com 1075162869 7405 192.168.12.62 (27 Jan 2004 00:21:09 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040125205219.GE26600@luna.mooo.com>,
Micha Feigin  <michf@post.tau.ac.il> wrote:

| There are two things to do. First you should mount the disk with the
| noatime option.

Hopefully on an idle system there isn't any access, so there isn't any
atime impact. It would be nice if the atime write was very lazy, as in
only when the file is closed or something. Like an atimeonclose option.

| The other thing is ext3 which is updating its journal every 5
| seconds. I was told that laptop-mode was imported into 2.6 by now (I
| think that it is in the main stream). Check the kernel docs there
| should be some mount option to state the dirty time for the ext3
| journal. The method changed since 2.4 so I don't remember the 2.6
| option since I don't use it yet, sorry.

Someone will have to explain that one, in a normal mount I would not
expect an idle system to be doing anything on the filesystems.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
