Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291224AbSBMBPQ>; Tue, 12 Feb 2002 20:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291226AbSBMBPD>; Tue, 12 Feb 2002 20:15:03 -0500
Received: from gear.torque.net ([204.138.244.1]:54029 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S291224AbSBMBOv>;
	Tue, 12 Feb 2002 20:14:51 -0500
Message-ID: <3C69BDFD.B9D6AA22@torque.net>
Date: Tue, 12 Feb 2002 20:14:37 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx 6.2.5 extra hunks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

> I was trying the new 6.2.5 version of AIC driver from 
> Justin Gibss, and as always it includes changes to the 
> generic SCSI layer. Are this really needed ????? (some 
> look just cosmetic if -> switch...)

Yes.

The patch to the mid level code is addressing the current
incorrect treatment of RECOVERED_ERROR. It is _not_ an
error but an advisory that a command (typically a READ)
need to be retried (or some other recovery technique) before
the data was obtained.

It is a "thought you might like to know your disk could
be failing (or why I took a long time to read that)" message
that the current scsi mid level interpretes as a command
failure.

While we are more than happy to have Justin Gibbs maintain
the aic7xxx driver (and Doug Ledford the older one), when
he tries to patch the mid-level he has to compete with
lots of other "cooks" (myself included). So his patches to
the mid level become harder to apply as time elapses from
when he did his patch generation.

Please persevere.

Doug Gilbert
