Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274833AbTGaR3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274838AbTGaR3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:29:34 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:10376 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S274833AbTGaR3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:29:33 -0400
Message-ID: <3F2952B1.6060805@pacbell.net>
Date: Thu, 31 Jul 2003 10:32:33 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net> <20030731094231.GA464@elf.ucw.cz> <3F291B9E.10109@pacbell.net> <20030731140908.GB16463@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20030731140908.GB16463@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>>USB drivers don't talk suspend/resume yet, so they
>>won't notice missing features there.  Regressions
>>are a different story though.
>>
>>But I can imagine that usb-storage (or is that SCSI?)
>>might want to veto suspending devices that are being
>>used for some kinds of i/o.  Eventually it should exist.
> 
> 
> For what kind of I/O? I do not see a reason for disk to veto
> suspend. CD-burner might want to do that, but it still would be bad
> idea... (Running on battery, battery goes low, and you destroy your CD
> *and* your filesystem.

If it's in the middle of any kind of write, suspending would
seem to be unwise.  Say, writing to a swap partition...

Mostly I'm just saying that if vetoing ever makes sense
(and I understand that it does), USB drivers will need
to understand it too.

- Dave


