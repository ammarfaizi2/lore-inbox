Return-Path: <linux-kernel-owner+w=401wt.eu-S964770AbWLTKmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWLTKmz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 05:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWLTKmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 05:42:55 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:34308 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964770AbWLTKmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 05:42:54 -0500
Message-ID: <458913AC.7080300@s5r6.in-berlin.de>
Date: Wed, 20 Dec 2006 11:42:52 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] New firewire stack - updated patches
References: <20061220005822.GB11746@devserv.devel.redhat.com>
In-Reply-To: <20061220005822.GB11746@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
...
> to sum up the changes:
> 
>  - Got rid of bitfields.
> 
>  - Tested on ppc, ppc64 x86-64 and x86.
> 
>  - ioctl interface tested on 32-bit userspace / 64-bit kernels.
> 
>  - ASCIIfied sources.
> 
>  - Incorporated Jeff Garziks comments.
> 
>  - Updated to work with the new workqueue API changes.
> 
>  - Moved subsystem to drivers/firewire from drivers/fw.
> 
> plus a number of bug fixes.

Congrats. WRT the 1st, 3rd, and 5th item you are now ahead of mainline's
stack. :-)

> As mentioned last time, the stack still lacks isochronous receive
> functionality to be on par with the old stack, feature-wise.  This is
> the one remaining piece of feature work kernel-side.  When that is
> done, I have a couple of TODO items in user space:

Actually there are also eth1394 and pcilynx to be pulled over. Eth1394
should be quite easy to do for anybody after iso reception is settled in
your stack. Pcilynx could follow depending on developer interest. It's
increasingly rare hardware and the few old machines which have it can be
cheaply upgraded to OHCI (which performs better for SBP-2 anyway).

>  - Make a libraw1394 compatibility library

Consider using libraw1394 right from the start of this porting project.
If there is only one libraw1394 (which works with raw1394 and with
fw-device-cdev), enthusiasts might have an easier time to test your stack.

>  - Port libdv1394 to new isochronous API.
> 
> which will allow us to move most user space applications to the new
> stack.
...

-- 
Stefan Richter
-=====-=-==- ==-- =-=--
http://arcgraph.de/sr/
