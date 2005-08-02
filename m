Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVHBOoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVHBOoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVHBOmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:42:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31680 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261549AbVHBOkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:40:55 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
References: <1122908972.18835.153.camel@gaston>
	<20050802095312.GA1442@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 02 Aug 2005 08:40:25 -0600
In-Reply-To: <20050802095312.GA1442@elf.ucw.cz> (Pavel Machek's message of
 "Tue, 2 Aug 2005 11:53:12 +0200")
Message-ID: <m1ack0xuzq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> Why are we calling driver suspend routines in these ? This is _not_
>
> Well, reason is that if you remove device_suspend() you'll get
> emergency hard disk park during powerdown. As harddrives can survive
> only limited number of emergency stops, that is not a good idea.

Then the practical question is: do we suspend the disk by
calling device_suspend() for every device.  Or do we modify
the ->shutdown() method for the disk.

Eric
