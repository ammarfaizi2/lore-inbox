Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbTL2PRp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 10:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbTL2PRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 10:17:45 -0500
Received: from net4visions.de ([217.160.106.106]:58441 "EHLO
	smtp.net4visions.de") by vger.kernel.org with ESMTP id S263537AbTL2PRn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 10:17:43 -0500
Message-ID: <3FF04584.9010606@tower-net.de>
Date: Mon, 29 Dec 2003 16:17:24 +0100
From: Markus Kolb <usenet@tower-net.de>
Organization: tower networks
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: tcp socks at close_wait for days without process
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.23.0.2; VDF: 6.23.0.19; host: mail.tower-net.all)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have a problem with this close_wait state in tcp connections.

There is no process left in the process list which could belong to the
specific port.
It is known that the application has bugs, but shouldn't the Linux
kernel manage this close_wait state and free the port after a while?
I believe I could wait for months and years and the close_wait won't go
away without a reboot.

At the moment I am using a Debian kernel-image 2.4.22-1.
But with older Debian kernel-images and SuSE images (I think I have also
tried a 2.4 vanilla) you can watch this behavior, too.

I have watched a 2nd strange kernel behavior. For that I don't know how
to reproduce.
A server application listened at a specific port. The application
crashed and no process belonging to this application was in process list
anymore. But the listening socket alives for about 5 minutes although
there was no process. How this can be? A listening port without a daemon
process belonging to it?
After the 5 minutes I have rebooted.

Am I wrong about the possibilities of the kernel?

Bye
Markus


