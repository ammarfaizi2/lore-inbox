Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbUC1DRO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 22:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUC1DRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 22:17:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36538 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262068AbUC1DRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 22:17:09 -0500
Message-ID: <406643A8.2050808@pobox.com>
Date: Sat, 27 Mar 2004 22:16:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Ryan Earl" <heretic@clanhk.org>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Status of the sata_sil driver for the VT8237
References: <4066342B.4080105@clanhk.org>
In-Reply-To: <4066342B.4080105@clanhk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Ryan Earl wrote:
> I was wondering, what is the state of the sata_sil driver for the VIA 
> VT8237 southbridge (ie the one used commonly on their K8T 
> motherboards).  Is this still beta?  Any known problems with it?

Well prior to the most recent version, calling it "beta" was putting it 
kindly.  I would call it broken :) which was why it was marked with 
CONFIG_BROKEN...

As of the most recent 2.6.5-rc2-bk snapshots, libata and sata_sil should 
be pretty happy with each other.

Some of the VIA problems were actually platform-related.  "noapic", 
"nomce", turning -on- local APIC support, and a few other workarounds 
have been found for these.

If you're on x86-64, make sure you have the latest BIOS version, too.

	Jeff




