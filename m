Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbTDRMRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 08:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbTDRMRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 08:17:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50636
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263026AbTDRMRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 08:17:31 -0400
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
       Patrick Mochel <mochel@osdl.org>,
       Grover Andrew <andrew.grover@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030418073754.GA2753@kroah.com>
References: <20030417150926.GA25402@gtf.org>
	 <200304171547.h3HFljoK000140@81-2-122-30.bradfords.org.uk>
	 <20030418073754.GA2753@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050665407.1218.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Apr 2003 12:30:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-18 at 08:37, Greg KH wrote:
> > Hmm, well what about with a PCI hotswap capable board - presumably
> > then we could have the situation where a new VGA card appears that we
> > _have_ to POST?
> 
> PCI Hotplug does not support video cards for just this reason.

Crap reason. You let the /sbin/hotplug helper use LRMI to post the card. 
The technology side is not that hard except for the problems with X 
sticking its nose in places it shouldnt and the PCI user space access
from kernel being too weak for some stuff.

