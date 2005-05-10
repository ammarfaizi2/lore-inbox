Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVEJGHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVEJGHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 02:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVEJGHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 02:07:43 -0400
Received: from uslec-66-255-166-25.cust.uslec.net ([66.255.166.25]:2534 "EHLO
	mail.ultrawaves.com") by vger.kernel.org with ESMTP id S261540AbVEJGHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 02:07:39 -0400
Message-ID: <42804FA9.3020307@lammerts.org>
Date: Tue, 10 May 2005 02:07:37 -0400
From: Eric Lammerts <eric@lammerts.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Markus Klotzbuecher <mk@creamnet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
References: <20050509183135.GB27743@mary>
In-Reply-To: <20050509183135.GB27743@mary>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Klotzbuecher wrote:
> mini_fo is a virtual kernel filesystem that can make read-only file
> systems writable.

Nice.

Some remarks:
Some functions return -ENOTSUPP on error, which makes "ls -l" complain 
loudly when getxattr() fails. This should be -EOPNOTSUPP.

The module taints the kernel because of MODULE_LICENSE("LGPL").
Since all your copyright statements say it's GPL software, better change 
this to "GPL".

cheers,

Eric
