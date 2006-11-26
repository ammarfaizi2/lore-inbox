Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935231AbWKZBd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935231AbWKZBd3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 20:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935229AbWKZBd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 20:33:29 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:13537 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S935227AbWKZBd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 20:33:28 -0500
Message-ID: <4568EEE5.3080301@bellsouth.net>
Date: Sat, 25 Nov 2006 19:33:25 -0600
From: Jay Cliburn <jacliburn@bellsouth.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Luca Tettamanti <kronos.it@gmail.com>
CC: Chris Snook <csnook@redhat.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] atl1: Revised Attansic L1 ethernet driver
References: <20061125224358.GA29403@dreamland.darkstar.lan>
In-Reply-To: <20061125224358.GA29403@dreamland.darkstar.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Tettamanti wrote:

> Got the board, done some basic testing: so far so good :)
> 
> The controller also supports MSI and (at least with my chipset - G965)
> it works fine:
> 
> 218:      80649          0   PCI-MSI-edge      eth1
> 
> which is nice, otherwise it ends up sharing the IRQ with SATA and USB.
> 
> I also have a small patch:

Thanks for the patch.  We'll add it for the next version.

FYI, TSO performance is _really_ bad; your tx speed will drop dramatically with 
TSO on (and it's on by default).  I haven't yet been able to find the problem. 
If you want to improve tx performance, turn off TSO with ethtool.

Jay
