Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318386AbSHELid>; Mon, 5 Aug 2002 07:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318387AbSHELid>; Mon, 5 Aug 2002 07:38:33 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:3069 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318386AbSHELic>; Mon, 5 Aug 2002 07:38:32 -0400
Subject: Re: Linux 2.4.19-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Daniela Engert <dani@ngrt.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <m11y9dsj0q.fsf@frodo.biederman.org>
References: <200208041939.VAA15993@myway.myway.de>
	<1028494876.15495.17.camel@irongate.swansea.linux.org.uk> 
	<m11y9dsj0q.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 14:00:46 +0100
Message-Id: <1028552446.18156.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 11:21, Eric W. Biederman wrote:
> Why are we kicking IDE devices out of ``legacy'' mode?
> 
> Last I checked that was a very sensible mode for IDE devices to operate in.
> The IRQ and pio resources are where a lot of software expects them,
> and by using an isa-irq there are fewer shared interrupts.
> 
> Plus on the few motherboards I tried it on, the pci-irq line didn't
> even appear to be hooked up.  In these cases I'm thinking of the
> on-board IDE controller.

See ac3/ac4. Having tried this approach it turns out to be a very bad
idea indeed. I'm now allowing pci_enable_device with a mask of BARs that
must be assigned. Thats somewhat less invasive

