Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWB1MAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWB1MAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWB1MAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:00:19 -0500
Received: from mail.dvmed.net ([216.237.124.58]:11652 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932203AbWB1MAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:00:17 -0500
Message-ID: <44043B4E.30907@pobox.com>
Date: Tue, 28 Feb 2006 07:00:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com> <20060228114500.GA4057@elf.ucw.cz>
In-Reply-To: <20060228114500.GA4057@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> I hate to see debugging infrastructure like this. We already have it
> in ACPI and it is nasty/useless. It hides serious errors during normal
> run, while if you turn on the debugging, it floods logs so that
> it is unusable, too. I end up having to replace dprintks with
> printks... nasty.

Then you clearly don't understand what the code is doing.  Fine-grained 
message selection allows one to turn on only the messages needed, and 
only for the controller desired.  Otherwise, it is nearly impossible to 
debug one SATA controller while booting off another.

	Jeff


