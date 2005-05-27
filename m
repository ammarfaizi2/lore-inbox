Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbVE0K3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVE0K3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 06:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVE0K3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 06:29:40 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:21412 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262422AbVE0K3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 06:29:33 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: question about /dev/console and /dev/tty
Date: Fri, 27 May 2005 10:29:32 +0000 (UTC)
Organization: Cistron
Message-ID: <d76sqc$suq$1@news.cistron.nl>
References: <4296C5C0.4030409@avantwave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1117189772 29658 194.109.0.112 (27 May 2005 10:29:32 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4296C5C0.4030409@avantwave.com>,
Tomko  <tomko@avantwave.com> wrote:
>Hi everyone,
>
>Which device is /dev/console pointing to ? or is it a virtual device ? 
>Actually why this node is made?

See linux/Documentation/serial-console.txt

>Why kernel default not providing a control terminal on /dev/console but 
>on other device ?

Because some daemons open /dev/console to send last resort error
messages to, and you do not want them to unexpectedly gain a
controlling tty.

>It is not surprising that we can use CTRL-C to terminate some process on 
>i386 linux on the Desktop machine,  is that mean the shell on our 
>desktop is not using /dev/console ? so where are the shell running on?

/dev/tty1, /dev/tty2 etc

Mike.

