Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVBWI1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVBWI1U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 03:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVBWI1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 03:27:20 -0500
Received: from quechua.inka.de ([193.197.184.2]:48011 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261420AbVBWI1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 03:27:10 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: uninterruptible sleep lockups
References: <421A3414.2020508@nodivisions.com>
Organization: private Linux site, southern Germany
Date: Tue, 22 Feb 2005 22:31:03 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E1D3hcW-0002h0-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <421A3414.2020508@nodivisions.com> you write:
> The most recent one was yesterday: I had run lsusb in the morning and had no
> problems, but at the end of the day I ran it again, and after outputting 3
> lines of data, it hung, stuck in D-state.  So now I have this:
>
> [/home/user]$ ps aux|grep D
> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> root        92  0.0  0.0     0    0 ?        D    Feb19   0:00 [khubd]
> root       845  0.0  0.0     0    0 ?        D    Feb19   0:00 [knodemgrd_0]
> root     29016  0.0  0.1  1512  592 ?        D    00:28   0:00 lsusb

I'm getting fairly repeatable deadlocks of this kind involving khubd
with a USB storage device. Perhaps there's just a faulty locking issue
in khubd.

Olaf

PS. Linux 2.6.9

