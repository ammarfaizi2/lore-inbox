Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUDSLSu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 07:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUDSLSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 07:18:50 -0400
Received: from mail.shareable.org ([81.29.64.88]:10404 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264346AbUDSLSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 07:18:48 -0400
Date: Mon, 19 Apr 2004 12:18:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       Andrew Morton <akpm@osdl.org>, Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       b-gruber@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
Message-ID: <20040419111831.GA13759@mail.shareable.org>
References: <Pine.GSO.4.58.0402271451420.11281@stekt37> <Pine.GSO.4.58.0404191124220.21825@stekt37> <20040419015221.07a214b8.akpm@osdl.org> <xb77jwci86o.fsf@savona.informatik.uni-freiburg.de> <1082372020.4691.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082372020.4691.9.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> well, it's the kernels job to abstract hardware. You don't also expose
> raw scsi and ide devices to userspace, you abstract them away and
> provide a uniform "block device" interface to userspace.

Not quite.  Both SCSI and IDE layers offer "generic" access for
sending commands to the device which the kernel doesn't understand.

> The input layer tries to do the same wrt HID devices and imo it makes
> sense. Why should userspace care if a mouse is attached to the USB port
> or via the USB->PS/2 connector thingy to the PS/2 port. Requiring
> different configuration for both cases, and potentially even requiring
> different userspace applications for each type make it sound like
> abstracting this away from userspace does have merit. 

I agree in this case: the touchpad should be handled by the input
layer, for uniformity if nothing else.

However, what happens when the thing connected to the PS/2 port isn't
a mouse or keyboard, just a strange device talking bytes?  With 2.4
kernels you could talk to it.

-- Jamie



