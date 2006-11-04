Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965747AbWKDXsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965747AbWKDXsX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 18:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965749AbWKDXsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 18:48:23 -0500
Received: from smtpout.mac.com ([17.250.248.171]:9423 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965748AbWKDXsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 18:48:23 -0500
In-Reply-To: <Pine.LNX.4.64.0611050034480.26021@artax.karlin.mff.cuni.cz>
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com> <Pine.LNX.4.64.0611050034480.26021@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AA4E0826-81F3-47AF-8C5E-D691BB02AB32@mac.com>
Cc: Albert Cahalan <acahalan@gmail.com>, kangur@polcom.net,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: New filesystem for Linux
Date: Sat, 4 Nov 2006 18:46:41 -0500
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 04, 2006, at 18:38:11, Mikulas Patocka wrote:
> But how will fdisk deal with it? Fdisk by default aligns partitions  
> on 63-sector  boundary, so it will make all sectors misaligned and  
> seriously kill performance even if filesystem uses proper 8-sector  
> aligned accesses.

Don't use a partition-table format that dates back to drives with  
actual reported physical geometry and which also maxed out at 2MB or  
so?  Even the mac-format partition tables (which aren't that much  
newer) don't care about physical drive geometry.

Besides, unless you're running DOS, Windows 95, or some random  
ancient firmware that looks at your partition tables or whatever you  
can just tell fdisk to ignore the 63-sector-alignment constraint and  
align your partitions more efficiently anyways.  But if you're  
dealing with hardware so new it supports 4k or 8k sectors, you really  
should be using EFI or something.

Cheers,
Kyle Moffett

