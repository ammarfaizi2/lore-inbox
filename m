Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVKSOF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVKSOF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 09:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVKSOF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 09:05:29 -0500
Received: from mail.gondor.com ([212.117.64.182]:8967 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1751121AbVKSOF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 09:05:29 -0500
Date: Sat, 19 Nov 2005 15:05:28 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
Message-ID: <20051119140527.GA4725@knautsch.gondor.com>
References: <20051116181612.GA9231@knautsch.gondor.com> <20051117223340.GD14597@elf.ucw.cz> <437E215E.30500@tmr.com> <20051118232019.GA2359@spitz.ucw.cz> <437EE4B3.2090408@samwel.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437EE4B3.2090408@samwel.tk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 09:39:15AM +0100, Bart Samwel wrote:
> * A significant proportion of the people who *do* have trouble see 
> messages about DMA timeouts. The problems do also occur on other 
> hardware, but seem to be most pronounced on Thinkpad T40s. On those 
> machines, the DMA timeout problems are triggered *especially* when the 
> madwifi drivers are loaded (see 
> http://bugzilla.ubuntu.com/show_bug.cgi?id=6108).

That's interesting. Both Bradley and me are using ipw2200, an in the
madwifi thread, one person also mentions he is using this driver. I
don't know if madwifi and ipw2200 use common or very similar code. But
perhaps this problem really is caused by a combination of laptop
mode / disk spinup and certain wireless drivers?

As far as I remember all corruptions I observed happened while being
connected to wireless lan. But that alone never triggered the bug, I had
to enable laptop mode as well.

Unfortunately, I still have to find a way to reliably trigger the
problem. None of my test scripts which try to trigger disk activity
while the drive is spun down caused any corruption yet.

Jan


