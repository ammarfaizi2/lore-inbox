Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUFFAOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUFFAOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 20:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUFFAOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 20:14:25 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:15337
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S262453AbUFFAOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 20:14:21 -0400
Subject: Re: EFI-support for SMBIOS driver
From: Michael Brown <Michael_E_Brown@Dell.com>
Reply-To: Michael_E_Brown@Dell.com
To: davidm@hpl.hp.com
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <16577.17064.857172.598873@napali.hpl.hp.com>
References: <16577.6469.833064.763671@napali.hpl.hp.com>
	 <20040605032902.GA7069@kroah.com>
	 <16577.17064.857172.598873@napali.hpl.hp.com>
Content-Type: text/plain
Organization: Dell Inc
Message-Id: <1086480479.15687.12854.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 05 Jun 2004 19:07:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry David.

I was the original submitter. Somebody kindly pointed out to me
(offline) the error of my ways, and I was able to get my userspace lib
to work just fine using mmap() instead of read(). This takes care of two
out of three of the main reasons I orignally submitted this driver.

Since my library was the only user of this lib, and I no longer need it,
I asked several people if it would make sense to continue to support it
or to pull it. The consensus was not to "bloat" the kernel with extra
stuff if it can be done via /dev/mem.

If there are strong sentiments the other way, the code is still out
there if somebody else wants to take over. I looked at what it would
take to add EFI support for this, and it would be trivial. I just didn't
want to become yet another absentee-maintainer if I no longer need the
code. 
--
Michael Brown

On Fri, 2004-06-04 at 22:48, David Mosberger wrote:
> >>>>> On Fri, 4 Jun 2004 20:29:02 -0700, Greg KH <greg@kroah.com> said:
> 
>   Greg> On Fri, Jun 04, 2004 at 05:52:21PM -0700, David Mosberger
>   Greg> wrote:
> 
>   >> The patch below adds EFI support to the SMBIOS driver.
> 
>   Greg> The smbios driver is gone in 2.6.7-rc.  You don't need a
>   Greg> driver for this, as you can do everything from userspace.
> 
> I know full well that it can be done in user-level --- via /dev/mem,
> which lots of people dislike.  I certainly don't feel strongly about
> it, but the SMBIOS driver made sense to me.
> 
> 	--david

