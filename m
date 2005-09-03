Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVICQGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVICQGe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVICQGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:06:34 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:33443 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751205AbVICQGd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:06:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XFjSjPC1giJGToXYi0wIBUvqvRUxaRGv1g5/XzGC1EB2jB891kSrOTrp8Xz3tE2GPyc0IyQwNE5T3WRopxdg6lldUiIFbTEKUIUwUS3aXVulAf1o7mu/kgeHtzgMUaDKL551xSBleIHjLf0fkb1seqvL0dKYSfF7kqIwJnGaVq0=
Message-ID: <3afbacad05090309064b3cad87@mail.gmail.com>
Date: Sat, 3 Sep 2005 18:06:33 +0200
From: Jim MacBaine <jmacbaine@gmail.com>
To: Ed L Cashin <ecashin@coraid.com>
Subject: Re: aoe fails on sparc64
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <87k6i0bnyn.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3afbacad0508310630797f397d@mail.gmail.com>
	 <87vf1mm7fk.fsf@coraid.com>
	 <20050831.232430.50551657.davem@davemloft.net>
	 <87k6i0bnyn.fsf@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/05, Ed L Cashin <ecashin@coraid.com> wrote:

> The aoe driver looks OK, but it turns out there's a byte swapping bug
> in the vblade that could be related if he's running the vblade on a
> big endian host (even though he said it was an x86 host), but I
> haven't heard back from the original poster yet.

It is in fact a x86_64 kernel, but with a mostly x86 userland. Vblade
is pure x86 code.

> The vblade bug was the omission of swapping the bytes in each short.
> The fix below shows what I mean:

Unfortunately it doesn't fix anything here. The client still reports
the same wrong size as before.  The dmesg output is identical, too.

Regards,
Jim
