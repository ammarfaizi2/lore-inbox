Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbTFSAIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbTFSAIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:08:11 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:3058 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S265639AbTFSAHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:07:07 -0400
Date: Wed, 18 Jun 2003 17:20:07 -0700
From: Chris Wright <chris@wirex.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI device list locking - take 2
Message-ID: <20030618172007.C20182@figure1.int.wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20030618212921.GA1807@kroah.com> <20030618153324.A20212@figure1.int.wirex.com> <20030618224609.GB2215@kroah.com> <20030618163237.A21050@figure1.int.wirex.com> <20030618235232.GA2667@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030618235232.GA2667@kroah.com>; from greg@kroah.com on Wed, Jun 18, 2003 at 04:52:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Wed, Jun 18, 2003 at 04:32:37PM -0700, Chris Wright wrote:
> > I'm not sure testing a valid ->next makes sense.  It could be non-NULL,
> > but poison, or if it was using list_del_init, it would be stuck in loop.
> 
> When we take the devices off of the list, after list_del(), still under
> the lock, we can null out the list pointers.  Then, later under the
> lock, we can check the pointer before we move to it.  We aren't doing
> fancy list_* functions with the pci device lists at all.

Ah, ok, that should work.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
