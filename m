Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319834AbSINAQi>; Fri, 13 Sep 2002 20:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319835AbSINAQi>; Fri, 13 Sep 2002 20:16:38 -0400
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:59908 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S319834AbSINAQh>; Fri, 13 Sep 2002 20:16:37 -0400
Date: Sat, 14 Sep 2002 02:21:26 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Possible bug and question about ide_notify_reboot in drivers/ide/ide.c (2.4.19)
Message-ID: <20020914002126.GD26758@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020913023744.78077.qmail@web40510.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913023744.78077.qmail@web40510.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Alex Davis wrote:

> Second, why do we need to put the disks on standby before halting? I ask because putting

To make the broken ones flush their caches...

> the disks on standby puts my hard drives into a coma!! When I power up after a halt, I have

hard to believe. IDE drives spin up automatically from standby mode. If
not, they're broken. Plus, IDE drives will spin up from any state except
"defective" or "power loss" with a soft reset (and only broken drives
will lose their write cache over soft reset).

> to go into the BIOS and force auto-detect to wake them back up. I've removed the "standby"
> code and things seem to be functioning normally. I have an Epox 8K7A motherboard with two
> Maxtor Hard drives (model 5T040H4).

My Maxtor 4W060H4 behaves well in standby.

Workaround: do a reboot :-)

-- 
Matthias Andree
