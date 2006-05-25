Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWEYFVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWEYFVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 01:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWEYFVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 01:21:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33943 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965015AbWEYFVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 01:21:38 -0400
Date: Thu, 25 May 2006 00:12:34 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Shaohua Li <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Tigran Aivazian <tigran@veritas.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       "Van De Ven, Adriaan" <adriaan.van.de.ven@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] microcode update driver rewrite
Message-ID: <20060525041234.GA22024@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Shaohua Li <shaohua.li@intel.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Tigran Aivazian <tigran@veritas.com>,
	Rajesh Shah <rajesh.shah@intel.com>,
	"Van De Ven, Adriaan" <adriaan.van.de.ven@intel.com>,
	Andrew Morton <akpm@osdl.org>
References: <1148529049.32046.103.camel@sli10-desk.sh.intel.com> <20060525040557.GA30175@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525040557.GA30175@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 09:05:57PM -0700, Greg Kroah-Hartman wrote:

 > Don't use request_firmware, use request_firmware_nowait() instead.  That
 > way you never stall.  You only want to update the firmware when
 > userspace tells you to, not for every boot like I think this will do.

But the CPU microcode *does* need reloading on each boot, as it's stored
in volatile memory that goes away on reboot.

		Dave

-- 
http://www.codemonkey.org.uk
