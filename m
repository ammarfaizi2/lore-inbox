Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWHXVHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWHXVHe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWHXVHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:07:34 -0400
Received: from outbound-mail-07.bluehost.com ([67.138.240.207]:62946 "HELO
	outbound-mail-07.bluehost.com") by vger.kernel.org with SMTP
	id S1030388AbWHXVHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:07:33 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC] maximum latency tracking infrastructure
Date: Thu, 24 Aug 2006 14:08:03 -0700
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
References: <1156441295.3014.75.camel@laptopd505.fenrus.org>
In-Reply-To: <1156441295.3014.75.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608241408.03853.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 71.198.43.183 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 24, 2006 10:41 am, Arjan van de Ven wrote:
> The reason for adding this infrastructure is that power management in
> the idle loop needs to make a tradeoff between latency and power
> savings (deeper power save modes have a longer latency to running code
> again).

What if a processor was already in a sleep state when a call to 
set_acceptable_latency() latency occurs?  Should there be a callback so 
they can be woken up?  A callback would also allow ACPI to tell the 
user "disabling C3 because of device <foo>" or somesuch, which might be 
nice.

Also, should subsystems have the ability to set a lower bound on  
latency?  That would mean set_acceptable_latency() could fail, 
indicating that the user should buy a better device or a system with 
better realtime guarantees, which is also valuable info.

Comments aside, this is a nice interface, should help clarify things for 
devices with response time limits.

Thanks,
Jesse
