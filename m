Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTEMPrm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbTEMPrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:47:42 -0400
Received: from b.smtp-out.sonic.net ([208.201.224.39]:57039 "HELO
	b.smtp-out.sonic.net") by vger.kernel.org with SMTP id S261624AbTEMPrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:47:40 -0400
X-envelope-info: <dhinds@sonic.net>
Date: Tue, 13 May 2003 09:00:22 -0700
From: David Hinds <dhinds@sonic.net>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Hinds <dahinds@users.sourceforge.net>
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
Message-ID: <20030513090022.A12249@sonic.net>
References: <1052775331.1995.49.camel@diemos> <1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk> <1052742964.1467.3.camel@doobie> <20030512234828.C17227@flint.arm.linux.org.uk> <1052839384.2255.10.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052839384.2255.10.camel@diemos>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 10:23:05AM -0500, Paul Fulghum wrote:
> 
> Which brings up a question:
> The include/pcmcia/ds.h file defines the dev_link_t
> structure that contains the release timer_list member.
> 
> Should I continue to initialize this member in
> my driver or will this member be eliminated requiring
> that all references to this member be removed from
> the individual PCMCIA drivers?

You shouldn't need to initialize it in your driver, since you've
eliminated the actual usage of the timer.

-- Dave
