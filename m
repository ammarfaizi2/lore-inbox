Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264596AbUEJJ6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264596AbUEJJ6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 05:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbUEJJ6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 05:58:13 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264596AbUEJJ6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 05:58:08 -0400
Date: Mon, 10 May 2004 11:03:56 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405101003.i4AA3uJt000135@81-2-122-30.bradfords.org.uk>
To: "Silviu Marin-Caea" <silviu@genesys.ro>, linux-kernel@vger.kernel.org
In-Reply-To: <33073.192.168.1.88.1084179033.squirrel@mail.genesys.ro>
References: <33073.192.168.1.88.1084179033.squirrel@mail.genesys.ro>
Subject: Re: dynamic allocation of swap disk space
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Quote from "Silviu Marin-Caea" <silviu@genesys.ro>:
> The way I see the solution is: allocate swap space dynamically, until
> there is no need for more or the disk becomes nearly full.  If that
> happens, then start thrashing it, all right.  Then when the condition is
> gone and things are back to normal deallocate the additional swap.

Very bad idea in my opinion.

Over allocating swap space is a BAD practice, but the effects are usually not
as apparent as under allocating swap space, and such a system works most of
the time, albeit often not as efficiently as it could do.  The solution is to
allocate the correct amount of swap space.  How much is that?  There is not
really a simple answer, and it's certainly not as simple as twice the physical
RAM.

A run-away process on a server with too much swap may well cause the machine
to become very unresponsive, whereas if the amount of virtual memory available
had been little more than what was expected to be required, the run-away
process would have terminated, allowing the problem to be fixed with minimal
disruption to other services.

John.
