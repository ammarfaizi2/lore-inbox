Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVJCPnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVJCPnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVJCPnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:43:50 -0400
Received: from [81.2.110.250] ([81.2.110.250]:4759 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751104AbVJCPns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:43:48 -0400
Subject: Re: [PATCH 2/3] Add disk hotswap support to libata RESEND #5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lukasz Kosewski <lkosewsk@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <355e5e5e0510030819od4ef8e5l93708588990081da@mail.gmail.com>
References: <355e5e5e05092618018840fc3@mail.gmail.com>
	 <433AEAAE.2070003@pobox.com>
	 <1127949651.26686.11.camel@localhost.localdomain>
	 <355e5e5e0510030819od4ef8e5l93708588990081da@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 17:09:31 +0100
Message-Id: <1128355771.26992.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-03 at 11:19 -0400, Lukasz Kosewski wrote:
> You mean something like "echo scsi-remove-single-device a b c d" >
> /proc/scsi/scsi?  I guess the sysfs equivalent?
> 
> > -       Interface for user to say "have swapped"
> 
> I suppose ditto.

Yes. A lot of PATA does swapping only if you tell it first so it can
kill IORDY or tristate the bus.

> > -       Post hotswap need to reconfigure both drives as if from scratch
> 
> Hmm, this seems far more complicated... basically during a swap
> operation, we have to shut down all I/O to the other drive on the
> cable (if there is one), if I read you correctly, and then reconfigure
> both drives once one is plugged in.

Yes.

> How about this; I want this SATA hotswapping stuff to be tested, so
> I'll commit my patches for 'SATA only' for the time being.  I'll stare
> at them for a while and then see what kind of PATA-specific if
> statements and hooks are necessary in the code?

Makes sense to me - the PATA stuff is slowly developing and its getting
closer to submittable as bits of the core code get merged.

