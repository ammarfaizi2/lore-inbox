Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTDNX2P (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 19:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbTDNX2P (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 19:28:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:60334 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263786AbTDNX2O (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 19:28:14 -0400
Subject: Re: readprofile ; Meaning of "Length of procedure"
From: Andy Pfiffer <andyp@osdl.org>
To: Shesha@asu.edu
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <Pine.GSO.4.21.0304141615360.9127-100000@general2.asu.edu>
References: <Pine.GSO.4.21.0304141615360.9127-100000@general2.asu.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1050363582.1192.34.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 Apr 2003 16:39:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 16:23, Shesha@asu.edu wrote:
> Thanks a lot Andy, one this that is bothering me is,
> Say if the load of procedures by executing the command mentioned by you is as
> follows in descending order....
> 
> 2604	__geneic_copy_to_user 		40.6875
> 1705	csum_patrial_copy_generic	6.8750
> 370	__generic_copy_from_user	3.75
> 764	do_annonymous_page		3.1754
> 176	handle_IRQ_event		1.5714
> 31	remove_wait_queue		0.96
> 
> the list goes on
> 
> are these procedures condidered as load on the CPU? how much of a load ?
> very high, high, moderate .....

Based only on the data from the fragment above, your relative percentage
of time spent breaks down like this (I'm using the 1st column):

	46%	__generic_copy_to_user (2604 / 5650)
	30%	csum_partial_copy_generic (1705 / 5650)
	13%	do_anonymous_page (764 / 5650)
	 6%	__generic_copy_from_user (370 / 5650)

Whatever you were doing when you collected this profile, your system was
spending roughly 76% of the time copying data from kernel space to user
space.

I can't tell you why it was doing that; for some applications this may
be expected and normal.  I don't find the "load" column all that useful
myself -- others will certainly differ.

Regards,
Andy



