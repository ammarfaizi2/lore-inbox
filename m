Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVHDOoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVHDOoC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVHDOlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:41:52 -0400
Received: from vena.lwn.net ([206.168.112.25]:41870 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262565AbVHDOj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:39:27 -0400
Message-ID: <20050804143924.21197.qmail@lwn.net>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 partition support driver methods 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Thu, 04 Aug 2005 17:35:02 +0530."
             <C349E772C72290419567CFD84C26E017042497@mail.esn.co.in> 
Date: Thu, 04 Aug 2005 08:39:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mukund JB. <mukundjb@esntechnologies.co.in> wrote:

> BUT, when a card is inserted in the socket 3, I am NOT able to mount and
> it says.
> Mount: /dev/tfa12 is not a valid block device
> 
> Can you convey me where exactly I am missing or why is it failing?

First step would be to look in /proc/partitions (and the system logfile)
to get an idea of what the kernel thinks is there.  When you call
add_disk(), the kernel should emit some messages noting the partitions
that it sees.  My guess is a mismatch of minor numbers between your
device nodes and what the kernel sees (it's hard for me to make complete
sense out of your minor number logic), but I could be wrong.

jon
