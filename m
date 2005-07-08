Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVGHTdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVGHTdJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVGHTam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:30:42 -0400
Received: from mx1.suse.de ([195.135.220.2]:65516 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262782AbVGHT3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:29:38 -0400
To: "Jon Schindler" <jonschindler@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB storage does not work with 3GB of RAM, but does with 2G of RAM
References: <200507081938.27815.s0348365@sms.ed.ac.uk.suse.lists.linux.kernel>
	<BAY20-F56DA47C91D7C093A5E426C4DB0@phx.gbl.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2005 21:29:37 +0200
In-Reply-To: <BAY20-F56DA47C91D7C093A5E426C4DB0@phx.gbl.suse.lists.linux.kernel>
Message-ID: <p734qb5p04e.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jon Schindler" <jonschindler@hotmail.com> writes:
> 
> This mainly seems to be an issue with USB mass storage devices like
> USB memory sticks and USB hard drives (I've tried both, and neither is
> assigned a scsi device properly).  I am still able to use my USB mouse
> when I have 3GB installed.  I'm not sure if that makes it a USB 1.1
> issue or a USB storage issue, but hopefully someone will have some
> insight after looking at the logs.  Thanks in advance for any help.

It sounds like the Nvidia EHCI controller has trouble DMAing to high
addresses. Would be a bad bug if true.

Does it work when you disable EHCI and only enable OHCI? (this will
limit you to USB 1.1) 

-Andi
