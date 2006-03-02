Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWCBPrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWCBPrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 10:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWCBPrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 10:47:12 -0500
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:19382 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1751549AbWCBPrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 10:47:11 -0500
Date: Thu, 2 Mar 2006 16:47:04 +0100
From: Gabor Gombas <gombasg@sztaki.hu>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: AMD64 X2 lost ticks on PM timer
Message-ID: <20060302154703.GE6913@boogie.lpds.sztaki.hu>
References: <200602280022.40769.darkray@ic3man.com> <p73veuzyr8p.fsf@verdi.suse.de> <20060301144641.GB20092@ti64.telemetry-investments.com> <200603011556.10139.ak@suse.de> <20060301154313.GC20092@ti64.telemetry-investments.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301154313.GC20092@ti64.telemetry-investments.com>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 10:43:13AM -0500, Bill Rugolsky Jr. wrote:

> My guess is the sata_nv driver, as it happens during heavy local file read.
> The machines all have 2-4 SATA WD Raptors connected to the mobo.

I have 4 SATA disks connected to an nForce4, being part of an md/raid5
array. If I start bonnie on the raid5 array, I get:

warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip __do_softirq+0x3b/0xa1

So sata_nv definitely looks fishy.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
