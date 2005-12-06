Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVLFWwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVLFWwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVLFWwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:52:22 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:695 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S965024AbVLFWwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:52:21 -0500
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
In-Reply-To: <20051206222001.GA14171@srcf.ucam.org>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Dec 2005 22:50:43 +0000
Message-Id: <1133909443.26777.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-06 at 22:20 +0000, Matthew Garrett wrote:
> stuff doesn't seem terribly important. The reason for it not currently 
> being implemented is that the IDE queues haven't been restarted at the 
> point where this code is called, so there's no obvious way of submitting 
> them to the drive yet.

Issue the task files in sequence to the drive directly with nIEN set and
poll them. In the libata case there is a clean API to do this but even
the old IDE has enough order and logic in this area it would not be hard
to do nicely.

