Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161857AbWKIWCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161857AbWKIWCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161858AbWKIWCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:02:37 -0500
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:30935 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S1161857AbWKIWCg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:02:36 -0500
Message-ID: <4553A57C.5070503@atipa.com>
Date: Thu, 09 Nov 2006 16:02:36 -0600
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Christoph Anton Mitterer <calestyo@scientia.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net> <45539188.5080607@atipa.com> <45539366.7070809@scientia.net> <45539588.7020504@atipa.com> <45539699.40105@scientia.net> <45539753.7060906@atipa.com> <4553A461.4080002@scientia.net>
In-Reply-To: <4553A461.4080002@scientia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2006 22:03:34.0234 (UTC) FILETIME=[E65DB3A0:01C7044A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Anton Mitterer wrote:
> It seems that I don't get any data at all.
> I only get the edac_mc module but none that seems to support my chipset
> or so...
> Any ideas?

The mc part does pci parity, it is separate from the
chipset driver, I have even used the _mc part on a
Itanium with no chipset driver at all and had it report
parity errors properly, so I expect just the mc driver
to work.

You would need the k8 module for the cpu, but that is
only if you want ECC checking also.

If you got the _mc loaded do a "sysctl -a | grep mc" and
see what things are set how, and reset if necessary
check_pci_parity to 1.

                      Roger
