Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVFJCXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVFJCXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 22:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVFJCXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 22:23:41 -0400
Received: from smtpout.mac.com ([17.250.248.73]:1754 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262367AbVFJCXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 22:23:39 -0400
In-Reply-To: <42A8ABDB.6080804@unixtrix.com>
References: <42A8ABDB.6080804@unixtrix.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A0454426-3FE0-42F4-BA87-8B0BE18DFEAC@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [OT] Re: BUG: Unusual TCP Connect() results.
Date: Thu, 9 Jun 2005 22:23:31 -0400
To: Alastair Poole <alastair@unixtrix.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 9, 2005, at 16:51:39, Alastair Poole wrote:
> The number of ports listed changes in size and they appear to be
> random.  For example, on one scan ports

> 22, 3455, 4532 and 6236

SSH and 3 RPC-based services, I would guess.  This is not a kernel
bug, there are probably userspace applications which are opening
those ports, even something as simple as an FTP client in active
mode would do it.  Please run "netstat -lp" to determine which
processes have opened each port.

> It is also interesting to note that a basic TCP nmap scan does not
> return these unusual results.

nmap doesn't scan higher-numbered ports by default, because those
ports are generally allocated dynamically by the kernel when user
programs indicate they do not care what port they are bound on.

Cheers,
Kyle Moffett
