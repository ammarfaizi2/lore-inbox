Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUAIRRQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 12:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbUAIRRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 12:17:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:36006 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263205AbUAIRRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 12:17:15 -0500
Date: Fri, 9 Jan 2004 09:17:10 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bridge-utils update for 2.6 ?
Message-Id: <20040109091710.1c156735.shemminger@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401091203540.28409@hosting.rdsbv.ro>
References: <1059.192.168.0.97.1073611363.squirrel@sml.dyndns.org>
	<3FFE3157.9030307@osdl.org>
	<2363.192.168.0.97.1073642603.squirrel@sml.dyndns.org>
	<Pine.LNX.4.58.0401091203540.28409@hosting.rdsbv.ro>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004 12:04:15 +0200 (EET)
Catalin BOIE <util@deuroconsult.ro> wrote:

> On Fri, 9 Jan 2004, Thomas Graham wrote:
> 
> > my god, what protocol could I use for STP replacement after it's removed
> > from the kernal code then ?!
> 
> The userlevel one. ;)

Yup, that's right.  Many people have requested enhanced STP support, and rather
than continuing to do it all in the kernel, the right way to do it is to have
a well-defined API (probably netlink), and a separate user level process to manipulate
the underlying routing.  Then (hopefully with help from the community) the daemon can
be enhanced (or replaced) as needed.

Don't worry ;-) the kernel and system won't break.  The existing in kernel STP
support will stay (probably as an option) for the life of 2.6; to accommodate
users using the existing utils.

