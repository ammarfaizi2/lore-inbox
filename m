Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273018AbTGaNmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272998AbTGaNlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:41:00 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:7613 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S272972AbTGaNkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:40:55 -0400
Message-ID: <3F291B9E.10109@pacbell.net>
Date: Thu, 31 Jul 2003 06:37:34 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net> <20030731094231.GA464@elf.ucw.cz>
In-Reply-To: <20030731094231.GA464@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>>All of which is a roundabout way of adding to what I
>>said:  the PM infrastructure USB will need to rely on
>>seems like it needs polishing yet!  :)
> 
> 
> Do you need vetoing? Otherwise it should be ready, except for APM.

USB drivers don't talk suspend/resume yet, so they
won't notice missing features there.  Regressions
are a different story though.

But I can imagine that usb-storage (or is that SCSI?)
might want to veto suspending devices that are being
used for some kinds of i/o.  Eventually it should exist.

- Dave


