Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVIEGfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVIEGfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 02:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVIEGfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 02:35:25 -0400
Received: from [65.195.187.51] ([65.195.187.51]:18816 "EHLO candi.us")
	by vger.kernel.org with ESMTP id S932248AbVIEGfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 02:35:24 -0400
Message-ID: <431BE71F.2040901@lorez.org>
Date: Sun, 04 Sep 2005 23:35:11 -0700
From: Bob Richmond <bob@lorez.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Immediate general protection errors on Tyan board
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Immediately upon boot on this system, most userland programs will 
segfault, including mount. This causes the system to come up in a 
bizarre state with the root filesystem mounted read-only, and nothing 
runs without segfault. There have been numerous similar posts about this 
problem, but they also seem to point to an associated kernel message, 
"Bad page state" that I don't observe. dmesg (which runs without 
segfault) returns many similar messages to:

start_udev[576] general protection rip:2aaaaae0fc70 rsp:7fffffb23d90 error:0

This occurrs on the latest Fedora Core 4 kernel RPM 
(kernel-2.6.12-1.1447_FC4) on a Tyan S2892 motherboard with 2 Opteron 
246 processors. The BIOS is up to date with what is available on Tyan's 
website for this board.

I'm not sure if the Fedora maintainers have rolled in the latest AMD 
errata changes from 2.6.13 in the latest package, but that will be my 
next test.

Does anyone still observe this problem in their systems?
