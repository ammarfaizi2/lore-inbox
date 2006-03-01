Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWCAPro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWCAPro (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWCAPro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:47:44 -0500
Received: from ns.suse.de ([195.135.220.2]:13719 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932393AbWCAPro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 10:47:44 -0500
From: Andi Kleen <ak@suse.de>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Subject: Re: AMD64 X2 lost ticks on PM timer
Date: Wed, 1 Mar 2006 16:47:33 +0100
User-Agent: KMail/1.9.1
Cc: Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org
References: <200602280022.40769.darkray@ic3man.com> <200603011556.10139.ak@suse.de> <20060301154313.GC20092@ti64.telemetry-investments.com>
In-Reply-To: <20060301154313.GC20092@ti64.telemetry-investments.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603011647.34516.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 16:43, Bill Rugolsky Jr. wrote:

> > I would suspect some driver.
> > Do you use any special addin cards? What modules are you using?
> 
> My guess is the sata_nv driver, as it happens during heavy local file read.
> The machines all have 2-4 SATA WD Raptors connected to the mobo.

Are you accessing all these disks in parallel with that cpio? If 
yes could you try it with only a single disk? 

My box only has a single SATA disk. Maybe there is some 
corner case in that SATA driver that leaks interrupt state
and it's only turned on later by idle or softirq then.

-Andi
