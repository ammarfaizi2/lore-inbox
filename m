Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbUAAAPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 19:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265309AbUAAAPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 19:15:53 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:31504 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265305AbUAAAPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 19:15:52 -0500
Date: Thu, 1 Jan 2004 01:15:49 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Rob Love <rml@ximian.com>
Cc: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040101001549.GA17401@win.tue.nl>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local> <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072901961.11003.14.camel@fur>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 03:19:22PM -0500, Rob Love wrote:

> We can get to the point where we don't even need the explicit concept of
> device numbers, but just "any old unique value" to use as a cookie.  The
> kernel can pull that number from anywhere, and notify user-space via
> udev ala hotplug.

My plan has been to essentially use a hashed disk serial number
for this "any old unique value". The problem is that "any old"
is easy enough, but "unique" is more difficult.
Naming devices is very difficult, but in some important cases,
like SCSI or IDE disks, that would work and give a stable name.

The kernel must not invent consecutive numbers - that does not
lead to stable names. Setting this up correctly is nontrivial.

