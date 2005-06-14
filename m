Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVFNMNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVFNMNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 08:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVFNMNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 08:13:24 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:36753 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261198AbVFNMNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 08:13:21 -0400
Date: Tue, 14 Jun 2005 14:13:20 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: P@draigBrady.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: optimal file order for reading from disk
Message-ID: <20050614121320.GA4739@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	P@draigBrady.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42AEBDC4.2050907@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AEBDC4.2050907@draigBrady.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 12:21:40PM +0100, P@draigBrady.com wrote:
> I know this will be dependent on filesystem, I/O scheduler, ...
> but given a list of files, what is the best (filesystem
> agnostic) order to read from disk (to minimise seeks).
> 
> Should I sort by path, inode number, getdents, or something else?

I know several projects that sort on inode number and benefit from that,
sometimes in a big way. The effect of this will probably be less on a
matured filesystem image.

I can't really explain why it helps though. I don't think the kernel will do
'crossfile readahead', although your disk might do so.

Google on 'orlov allocator', is enlightning.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
