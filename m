Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270032AbTGUMZO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269981AbTGUMYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:24:43 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:62473 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269961AbTGUMYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:24:22 -0400
Date: Mon, 21 Jul 2003 13:39:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/personality.h
Message-ID: <20030721133919.B24319@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org
References: <3F1BD193.3080701@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F1BD193.3080701@suse.de>; from hare@suse.de on Mon, Jul 21, 2003 at 01:42:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 01:42:11PM +0200, Hannes Reinecke wrote:
> Hi all,
> 
> the attached patch encloses the kernel-only parts of personality.h with
> __KERNEL__ to prevent them to be visible in userspace. This also fixes
> the nameclash between the macro personality() with the syscall
> personality() if the header file is included in an userspace program.
> Patch is against 2.4.21, should apply to 2.6.0-test1 equally.

Don't do that, the header shouldn't be used from userspace.  There's
a sys/personality.h for you in glibc 2.3.

