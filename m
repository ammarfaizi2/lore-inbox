Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbTGOUJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 16:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269641AbTGOUJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 16:09:37 -0400
Received: from screech.rychter.com ([212.87.11.114]:54458 "EHLO
	screech.rychter.com") by vger.kernel.org with ESMTP id S269639AbTGOUJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 16:09:36 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB bugs (was: networking bugs and bugme.osdl.org)
References: <1056755336.5459.16.camel@dhcp22.swansea.linux.org.uk>
	<20030627.172123.78713883.davem@redhat.com>
	<1056827972.6295.28.camel@dhcp22.swansea.linux.org.uk>
	<20030628.150328.74739742.davem@redhat.com>
	<m2vfu765cx.fsf@tnuctip.rychter.com> <20030713041557.GC2695@kroah.com>
	<m2isq4etz6.fsf_-_@tnuctip.rychter.com>
	<20030714230236.GA7195@kroah.com>
X-Spammers-Please: blackholeme@rychter.com
From: Jan Rychter <jan@rychter.com>
Date: Tue, 15 Jul 2003 13:24:57 -0700
In-Reply-To: <20030714230236.GA7195@kroah.com> (Greg KH's message of "Mon,
 14 Jul 2003 16:02:36 -0700")
Message-ID: <m2fzl7edwm.fsf@tnuctip.rychter.com>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:
 Greg> On Mon, Jul 14, 2003 at 01:25:33PM -0700, Jan Rychter wrote:
 >>
 >> I went ahead and retested all of my known USB problems against
 >> 2.4.22-pre5. It seems all usb-storage ones are gone, and there is
 >> only one bluetooth showstopper, fairly simple to reproduce:
 >>
 >> 1. boot the machine (using uhci)
 >> 2. insert a PCI BCM2033-based bluetooth adapter, observe the
 >>    firmware
 >> getting loaded, don't actually bring the hci0 interface up,
 >> 3. remove the adapter, everything looks fine
 >> 4. try to rmmod uhci and get:
 >> kmem_cache_destroy: Can't free all objects c12c7b40 uhci: not all
 >> urb_priv's were freed

 Greg> Is this reproducable on 2.6.0-test1?  

I can't reproduce this easily, as I haven't even tried 2.5.* kernels
yet.

 Greg> Does this happen using the usb-uhci driver instead of the uhci
 Greg> driver?  

I'll check this and report.

 Greg> And this doesn't cause a failure, right?  Just those messages in
 Greg> the log?

It is a showstopper, because the resulting corruption (?) breaks
software suspend. So, use bluetooth once, never suspend again.

--J.
