Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264037AbTFPXU6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 19:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTFPXU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 19:20:58 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:33547 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264037AbTFPXU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 19:20:57 -0400
Date: Tue, 17 Jun 2003 00:34:49 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Robert Love <rml@tech9.net>
cc: Gerhard Mack <gmack@innerfire.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71 - random console corruption
In-Reply-To: <1055799095.7069.120.camel@localhost>
Message-ID: <Pine.LNX.4.44.0306170032070.26878-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 2003-06-16 at 14:27, James Simmons wrote:
> 
> > Preempt and the VT console system are not friends. There are way to many 
> > global variables which have there states altered in many spots.
> 
> So why is this not an SMP race, too?

For userland<->kernel transactions we have the console_semaphore to 
protect us. It is also used for console_callback. The console_semaphore is
not used internally to protect global variables :-( To do this properly 
would take quite a bit of work.  

