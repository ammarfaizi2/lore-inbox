Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWAXLPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWAXLPS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 06:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWAXLPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 06:15:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15799 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030455AbWAXLPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 06:15:16 -0500
Date: Tue, 24 Jan 2006 12:14:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-ID: <20060124111459.GA1650@elf.ucw.cz>
References: <200601240929.37676.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200601240929.37676.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 24-01-06 09:29:37, Rafael J. Wysocki wrote:
> Hi,
> 
> This patch introduces a user space interface for swsusp.
> 
> The interface is based on a special character device, called the snapshot
> device, that allows user space processes to perform suspend and
> resume-related operations with the help of some ioctls and the read()/write()
> functions.  Additionally it allows these processes to allocate free swap pages
> from a selected swap partition, called the resume partition, so that they know
> which sectors of the resume partition are available to them.
> 
> The interface uses the same low-level system memory snapshot-handling
> functions that are used by the built-it swap-writing/reading code of swsusp.
> 
> The interface documentation is included in the patch.
> 
> The patch assumes that the major and minor numbers of the snapshot device
> will be 10 (ie. misc device) and 231, the registration of which has already been
> requested.
> 
> Please apply (Pavel, please ack if it looks good).

ACK.
						Pavel

-- 
Thanks, Sharp!
