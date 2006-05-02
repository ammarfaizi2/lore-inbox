Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWEBT3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWEBT3u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWEBT3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:29:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5303 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750875AbWEBT3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:29:50 -0400
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
	userspace (Xorg) to enable devices without doing foul direct access
From: Peter Jones <pjones@redhat.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       airlied@linux.ie, akpm@osdl.org
In-Reply-To: <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>
	 <44578C92.1070403@linux.intel.com>
	 <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
	 <44579028.1020201@linux.intel.com>
	 <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com>
	 <1146594457.32045.91.camel@laptopd505.fenrus.org>
	 <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com>
Content-Type: text/plain
Organization: Red Hat, Inc.
Date: Tue, 02 May 2006 15:29:41 -0400
Message-Id: <1146598181.3254.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 15:00 -0400, Jon Smirl wrote:
> I also can not see how user space suspend/resume can
> disable PCI hardware without coordinating with an active device
> driver.

And that's not a reasonable thing for userspace to do, if an active
device driver is using that.  But sometimes it might want to turn a
device on, perform some action, and then disable it again.

[...]
> You may call this silly but it is a real pain to spend hours debugging
> code only to discover that it failed because some other app unknown to
> you altered the state of the hardware while you were using it.

"Doctor, it hurts when I stab myself in the eye..."

-- 
  Peter

