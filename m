Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTIFJnH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 05:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTIFJnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 05:43:07 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:25103 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265062AbTIFJnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 05:43:01 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.0-test4 - PL2303 OOPS - see also 2.4.22: OOPS on disconnect PL2303 adapter
Date: Sat, 6 Sep 2003 15:55:46 +0800
User-Agent: KMail/1.5.2
References: <200309020139.08248.mhf@linuxmail.org> <20030905230852.GA18196@kroah.com> <20030906073814.GE14376@lug-owl.de>
In-Reply-To: <20030906073814.GE14376@lug-owl.de>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309061555.47065.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 September 2003 15:38, Jan-Benedict Glaw wrote:
> On Fri, 2003-09-05 16:08:52 -0700, Greg KH <greg@kroah.com>
> wrote in message <20030905230852.GA18196@kroah.com>:
> > On Wed, Sep 03, 2003 at 02:32:16PM +0800, Michael Frank wrote:
> > > On Wednesday 03 September 2003 07:52, Greg KH wrote:
> > > Besides it just stopping without obvious reason: 
> > > 
> > > 1) It does not like when something is typed on cu and not received by the serial port side 
> > >    connected to PL2303 (CTS low). It tends to hang and the trouble starts....
> > > 
> > > Sep  3 12:52:15 mhfl2 kernel: ttyUSB0: 1 input overrun(s)
> > > Sep  3 12:54:30 mhfl2 last message repeated 2 times
> > 
> > Hm, what is causing this?
> > That is probably why cu is getting confused, right?
> 
> I've seen the input overrun message also (with the vanilla driver, not
> patched).
> It's effect is that the first bytes (maybe up to 100..300
> bytes) are scrambled. It's like accessing a serial link with a horribly
> wrong baud rate.

I have seen that too, but rarely. Most the time it hangs after the first
few hundred bytes.

> 
> After a split-second, however, everything is okay and I start receiving
> valid NMEA data from my GPS receiver. For me, that's not much of a
> problem because nmea is checksum'ed and the bad bytes are ignored...
> 

I have used PL2303 so far to grab serial console messages and did not
get in synch with cu after the overrun popped up.

Regards
Michael

