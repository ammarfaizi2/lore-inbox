Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVFUE7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVFUE7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVFUE7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 00:59:13 -0400
Received: from dvhart.com ([64.146.134.43]:25265 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261571AbVFUE6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 00:58:14 -0400
Date: Mon, 20 Jun 2005 21:58:17 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: dipankar@in.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.12-git1 broken on x86_64 (works on 2.6.12)
Message-ID: <207600000.1119329897@[10.10.2.4]>
In-Reply-To: <20050620211826.GD4622@in.ibm.com>
References: <563690000.1119299756@flay> <20050620211826.GD4622@in.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Dipankar Sarma <dipankar@in.ibm.com> wrote (on Tuesday, June 21, 2005 02:48:26 +0530):

> On Mon, Jun 20, 2005 at 01:35:56PM -0700, Martin J. Bligh wrote:
>> Fails to reboot, see:
>> 
>> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/6035/debug/console.log
>> 
>> basically:
>> 
>> VFS: Cannot open root device "sda1" or unknown-block(0,0)
>> Please append a correct "root=" boot option
>> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
>> 
>> Looks like it didn't find the SCSI card at all ... MPT fusion, IIRC.
>> I'll poke at it a bit tommorow, but if you've got any good guesses as
>> to what broke it, let me know (hopefully something trivial like config
>> options).
> 
> If ABAT copies an older .config with CONFIG_FUSION=y, the new config
> disables it since it now has two different options CONFIG_FUSION_SPI
> and CONFIG_FUSION_FC. Try manually setting those two new fusion options.
> 
> I had to do this in 2.6.12-mm1.

Yay, that fixed it. Awesome - thanks ;-)

M.

