Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWJEUKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWJEUKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWJEUKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:10:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:33156 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751189AbWJEUKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:10:45 -0400
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
Date: Thu, 5 Oct 2006 22:10:39 +0200
User-Agent: KMail/1.9.3
Cc: discuss@x86-64.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <200610051910.25418.ak@suse.de> <200610052142.29692.ak@suse.de> <452564B9.4010209@garzik.org>
In-Reply-To: <452564B9.4010209@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052210.39930.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 22:02, Jeff Garzik wrote:
> Andi Kleen wrote:
> > If the choice is between a secret NDA only card with dubious
> > functionality and booting on lots of modern boards I know what to 
> > choose.
> 
> That's a strawman argument.  There is no need to choose.  You can 
> clearly boot on lots of modern boards with mmconfig just fine.  We just 
> need to narrow down which ones.

You want a huge white list or what? And you volunteer to maintain
it?

My current thinking is to just wait for Vista certified machines
and then use DMI year >= 2007 or so to enable it. 

Most likely your secret card won't ship before that anyways and 
maybe it can be even somehow used without MCFG. And if it can't
it is out of luck right now. Send blame to the BIOS writers
who are unable to get the MCFG tables right.

I don't think white list is the right answer though. If it
was only a small list of machines with broken BIOS it would
be possible to black list, but Intel pretty much sabotated that 
by releasing a broken reference BIOS that is used in lots of different
boards. 

I considered PCI ID checking for those chipsets instead of
SMBIOS checking, but that has other problems too.

-Andi
