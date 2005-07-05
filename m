Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVGESmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVGESmw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 14:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVGESms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 14:42:48 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:7857 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261961AbVGESmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 14:42:31 -0400
Date: Tue, 5 Jul 2005 11:42:18 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why cannot I do "insmod nfsd.ko" directly?
Message-Id: <20050705114218.20c494bc.rdunlap@xenotime.net>
In-Reply-To: <4ae3c140507051123758bb61e@mail.gmail.com>
References: <4ae3c140507051123758bb61e@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005 14:23:39 -0400 Xin Zhao wrote:

| I tried to do "insmod nfsd.ko", but always got the error message
| "insmod: error inserting 'nfsd.ko': -1 Unknown symbol in module"

The kernel message log would at least tell you what symbol
is missing and then you/we can determnine why and where that
symbol is located.  Maybe there's just another module that needs
to be loaded before nfsd.ko.  And try using modprobe instead
of insmod since modprobe will look for module dependencies.


| Why?
| 
| The kernel is 2.6.11.10
| The command I used is:
| 1. insmod lockd.ko  ---succeed
| 2. exportfs -r   ---succeed
| 3. insmod nfsd.ko --- failed 
| 
| 
| Moreover, I noticed that if I do the following commands, nfsd.ko can
| be inserted:
| 
| 1. rpc.mountd
| 2. exportfs -r
| 3. rpc.nfsd 1
| 
| Can someone explain what trick rpc.mountd and rpc.nfsd do to make
| nfsd.ko insertable?
| 
| Thanks in advance for your kind help!


---
~Randy
