Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWIHPtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWIHPtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWIHPtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:49:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35280 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750860AbWIHPtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:49:35 -0400
Date: Fri, 8 Sep 2006 11:56:39 -0400
From: Dave Jones <davej@redhat.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Message-ID: <20060908155639.GJ28592@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matt Domsch <Matt_Domsch@dell.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20060908031422.GA4549@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908031422.GA4549@lists.us.dell.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 10:14:22PM -0500, Matt Domsch wrote:
 > Problem:
 > New Dell PowerEdge servers have 2 embedded ethernet ports, which are
 > labeled NIC1 and NIC2 on the chassis, in the BIOS setup screens, and
 > in the printed documentation.  Assuming no other add-in ethernet ports
 > in the system, Linux 2.4 kernels name these eth0 and eth1
 > respectively.  Many people have come to expect this naming.  Linux 2.6
 > kernels name these eth1 and eth0 respectively (backwards from
 > expectations).  I also have reports that various Sun and HP servers
 > have similar behavior.
 
This came up years back when 2.6 was something new, and the answer
then was 'bind the interface to the MAC address'.

Whilst your patch will fix the case that's currently broken (2.4->2.6),
doesn't it offer equal possibility to break existing setups when people move
from <=2.6.18 -> 2.6.19 ?

	Dave
