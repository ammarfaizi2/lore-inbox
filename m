Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262863AbVCDCX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbVCDCX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVCDCTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:19:16 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:56768 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262009AbVCDCRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:17:23 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
Date: Thu, 3 Mar 2005 18:17:06 -0800
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Todd Poynor <tpoynor@mvista.com>,
       linux-pm@osdl.org, linux-kernel@vger.kernel.org
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com> <20050302085619.GA1364@elf.ucw.cz>
In-Reply-To: <20050302085619.GA1364@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503031817.06993.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 12:56 am, Pavel Machek wrote:
> 
> If OMAP has "big sleep" and "deep sleep", why not simply map them to
> "standby" and "suspend-to-ram"?

Or even "cpu idle".  Entering power saving modes shouldn't be such
a Big Deal.  Some of the variable scheduling timeout work has been
done specifically with the goal of letting the system use those low
power modes more generally, without needing user(space) input to
suggest that now would be a good time to conserve more milliWatts.

Of course, on systems that don't swap (or swsusp) there may be
dozens of different low-power "standby" states.  I'm not sure it
helps to try labeling them all through /sys/power/files.

- Dave
