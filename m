Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269964AbTGVV3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270079AbTGVV3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 17:29:51 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:1920 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S269964AbTGVV3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 17:29:49 -0400
Date: Tue, 22 Jul 2003 15:46:31 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Anders Gustafsson <andersg@0x63.nu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 gets corrupted data when loading init
Message-ID: <640742704.1058910391@aslan.btc.adaptec.com>
In-Reply-To: <20030718113950.GF5964@h55p111.delphi.afb.lu.se>
References: <20030718083458.GC5964@h55p111.delphi.afb.lu.se> <20030718095108.GE5964@h55p111.delphi.afb.lu.se> <20030718113950.GF5964@h55p111.delphi.afb.lu.se>
X-Mailer: Mulberry/3.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jul 18, 2003 at 11:51:08AM +0200, Anders Gustafsson wrote:
>> On Fri, Jul 18, 2003 at 10:34:58AM +0200, Anders Gustafsson wrote:
>> > It breaks between 2.5.70 and 2.5.70-bk1, which contains a update in the
>> > aic79xx-drivers, so my guess is related to that.
>> 
>> http://linux.bkbits.net:8080/linux-2.5/cset@1.1127.6.4 is the changeset that
>> makes it stop working.
> 
> Yeah, and reversing that on 2.6.0-test+bk with the attached patch makes it
> work on 2.6.0-test1.

There are a whole slew of later changesets that haven't made it in yet.
The root cause of your particular problem is not the lun copy optimization,
but a problem with the layout of a data structure that is dma'ed to the
controller and a controller errata.  The fix for this is available in 
the 20030603 bksend file at my site:

http://people.FreeBSD.org/~gibbs/linux/SRC/

I will try to find some time later this week to review the code that
is now in 2.6 and generate updated changesets for that branch.

--
Justin

