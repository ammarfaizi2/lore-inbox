Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbTDQN6U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 09:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbTDQN6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 09:58:19 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31686
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261393AbTDQN6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 09:58:19 -0400
Subject: Re: firmware separation filesystem (fwfs)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ranty@debian.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030417012321.GB9219@zax>
References: <20030416163641.GA2183@ranty.ddts.net>
	 <1050508028.28586.126.camel@dhcp22.swansea.linux.org.uk>
	 <20030417012321.GB9219@zax>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050585122.31390.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 14:12:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-17 at 02:23, David Gibson wrote:
> > But so would loading it from hotplug via ioctl. It might be we want
> > a clean hotplug way to ask for 'firmare for xyz'.
> 
> True, but ioctl()s are horrid.  And the driver needs to set up a
> suitable device to which the ioctl() is applied, and deal with binding
> the right image to the right instance, which can get messy in some

You are ignoring the main issue of discussion. I don't care if its
ioctl, tcp/ip over carrier pigeon or a pipe.

fwfs is a broken idea because it leaves the data in kernel space. On
a giant IBM monster maybe nobody cares about a few hundred K of cached
firmware in the kernel, but the rest of us happen to run real world
computers.

Catting the firmware to a device node also works fine for me as an 
API, but keep the firmware in userspace.



Alan

