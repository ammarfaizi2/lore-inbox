Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967200AbWLEKB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967200AbWLEKB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 05:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967457AbWLEKB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 05:01:59 -0500
Received: from attila.bofh.it ([213.92.8.2]:53804 "EHLO attila.bofh.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967200AbWLEKB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 05:01:59 -0500
Date: Tue, 5 Dec 2006 11:01:52 +0100
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.19-rc6] fix hotplug for legacy platform drivers
Message-ID: <20061205100152.GB5805@bongo.bofh.it>
References: <20061122135948.GA7888@bongo.bofh.it> <200611291727.31999.david-b@pacbell.net> <20061201070407.GL16413@suse.de> <200612041828.01381.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612041828.01381.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 05, David Brownell <david-b@pacbell.net> wrote:

> The pushback on $SUBJECT patch.  Which amounts to wanting to break hotplug
> for several busses, unless someone (NOT the folk promoting the breakage!)
Please explain in more details how hotplugging would be broken, possibly
with examples.

> There are really two issues here:
> 
>  - The "real one", as (yes!) fixed by the $SUBJECT patch.  Troublesome legacy
>    drivers, like "i82365", written so they can't hotplug ... but the kernel
>    hasn't previously known that.
> 
>  - The confusion, caused by a false identification of the "i82365" issue
>    being a problem related to module aliasing ... instead of being rooted in
>    the fact that it's a "legacy style" non-hotpluggable driver, since it
>    creates its own device node.

Nonsense. The purpose of $MODALIAS is to allow automatically loading
modules using the information provided by the bus driver.
Because of this reason there is no point for a driver to provide a
$MODALIAS referring to itself. It will only waste resources causing udev
to try loading it again.

-- 
ciao,
Marco
