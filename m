Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbVKXBbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbVKXBbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 20:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVKXBbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 20:31:12 -0500
Received: from main.gmane.org ([80.91.229.2]:58309 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932609AbVKXBbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 20:31:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Michael Renner <michael.renner@geizhals.at>
Subject: faulty oom-killer on amd64?
Date: Thu, 24 Nov 2005 01:26:57 +0000 (UTC)
Message-ID: <loom.20051124T013917-518@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 85.124.86.88 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing lack of OOM killing on two of our amd64/x86_64 servers. One is a
single core quad opteron with 32 gb ram, the other one a 8 processor dual core
opteron with 64 gb ram. We've got a perl script (which forks itself a few times)
which tends to eat up a lot of ram, eventually reaching the systems limits. I
bandaided the problem in the meanwhile with ulimits (while we try to figure out
why perl is misbehaving in the first place) but the kernel should also behave
properly when it's allocateable memory gets stretched thin.

On the four processor machine this usually ended up in the box freezing up more
or less (userland stalled, sysrq keys working though. I usually did a sync and
then rebooted, sending terms/kills to all processes worked rarely). A log of
such an event can be seen at http://phpfi.com/88425.

On the 16 processor machine I get CPU lockups with identical traces which can be
seen at http://666kb.com/i/10yov42ydfdog.jpg and
http://666kb.com/i/10yom358azw8w.jpg (this was tested with 2.6.14 and 2.6.15-rc2
respectively).

http://phpfi.com/88428 is the .config of the 16 processor machine and
http://phpfi.com/88429 of the 4 processor one.

Any ideas?

-- 

best regards,
 Michael Renner - Network services

Preisvergleich Internet Services AG
Obere Donaustraße 63/2, A-1020 Wien
Tel: +43 1 5811609 80
Fax: +43 1 5811609 55


