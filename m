Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbWBHQOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWBHQOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWBHQOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:14:36 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:25997 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161093AbWBHQOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:14:36 -0500
Date: Wed, 8 Feb 2006 16:14:35 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH 02/17] mips: namespace pollution - mem_... -> __mem_... in io.h
Message-ID: <20060208161435.GH27946@ftp.linux.org.uk>
References: <E1F6jSx-0002TE-Ur@ZenIV.linux.org.uk> <Pine.LNX.4.64N.0602081059020.27639@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602081059020.27639@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 11:01:52AM +0000, Maciej W. Rozycki wrote:
> On Wed, 8 Feb 2006, Al Viro wrote:
> 
> > A pile of internal functions use only inside mips io.h has names starting
> > with mem_... and clashing with names in drivers; renamed to __mem_....
> 
>  Then the corresponding ones with no "mem_" prefix (these for the PCI I/O 
> port space) should be prefixed with "__" for consistency as well.

Huh???

Things like outb(), etc. *are* public; mem_... ones are not. 
