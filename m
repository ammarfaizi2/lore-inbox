Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWEZFgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWEZFgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 01:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWEZFgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 01:36:13 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:25063 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1030212AbWEZFgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 01:36:12 -0400
Subject: Re: [PATCH 2/2] microcode update driver rewrite
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Dave Jones <davej@redhat.com>, Shaohua Li <shaohua.li@intel.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tigran Aivazian <tigran@veritas.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       "Van De Ven, Arjan" <arjan@linux.intel.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060525150224.GB1428@kroah.com>
References: <1148529049.32046.103.camel@sli10-desk.sh.intel.com>
	 <20060525040557.GA30175@kroah.com> <20060525041234.GA22024@redhat.com>
	 <20060525150224.GB1428@kroah.com>
Content-Type: text/plain
Date: Fri, 26 May 2006 07:35:55 +0200
Message-Id: <1148621755.3081.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-25 at 08:02 -0700, Greg KH wrote:
> On Thu, May 25, 2006 at 12:12:34AM -0400, Dave Jones wrote:
> > On Wed, May 24, 2006 at 09:05:57PM -0700, Greg Kroah-Hartman wrote:
> > 
> >  > Don't use request_firmware, use request_firmware_nowait() instead.  That
> >  > way you never stall.  You only want to update the firmware when
> >  > userspace tells you to, not for every boot like I think this will do.
> > 
> > But the CPU microcode *does* need reloading on each boot, as it's stored
> > in volatile memory that goes away on reboot.
> 
> Sorry about that, you are right.  But this will make the boot process a
> bit different than what it currently is, just make sure that the distros
> realize this change...


that's why there is a config option to keep the compatibility

