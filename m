Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVAUJyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVAUJyv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 04:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVAUJyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 04:54:51 -0500
Received: from mail-gw1.york.ac.uk ([144.32.128.246]:34196 "EHLO
	mail-gw1.york.ac.uk") by vger.kernel.org with ESMTP id S262218AbVAUJyt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 04:54:49 -0500
Subject: Re: 2.6.9 suspend-to-disk bug (during resume)
From: Alan Jenkins <aj504@student.cs.york.ac.uk>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200501201019.24378.rjw@sisk.pl>
References: <1106210882.7975.9.camel@linux.site>
	 <1106210985l.8224l.0l@linux>  <200501201019.24378.rjw@sisk.pl>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 09:45:27 +0000
Message-Id: <1106300727.6026.0.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-York-MailScanner: Found to be clean
X-York-MailScanner-From: aj504@student.cs.york.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 10:19 +0100, Rafael J. Wysocki wrote: 
> On Thursday, 20 of January 2005 09:49, Alan Jenkins wrote:
> > On 20/01/05 08:48:02, Alan Jenkins wrote:
> > I have noticed a similar message, and so has someone else on the list:
> > 
> > http://groups-beta.google.com/group/fa.linux.kernel/browse_thread/thread/1bfcbbca2d508bb3/cb69d674510d215a?q=%22bad:+scheduling+while+atomic!%22+suspend&_done=%2Fgroup%2Ffa.linux.kernel%2Fsearch%3Fgroup%3Dfa.linux.kernel%26q%3D%22bad:+scheduling+while+atomic!%22+suspend%26qt_g%3D1%26searchnow%3DSearch+this+group%26&_doneTitle=Back+to+Search&&d#cb69d674510d215a
> > 
> > I have an asrock motherboard with an sis chipset.
> > SiS seems to be the common factor.  I think its something general about
> > the chipset.  My messages seem to involve the network card, the sound
> > card and the i8042 (ps/2 port) controller:
> 
> Have you tried to boot with "pci=routeirq" or/and "noapic"?
> 
> Greets,
> RJW
> 

To no avail.  Pavels workaround (disable preempt) works though.

With regard to the ps/2 controller, the keyboard stops working after a
suspend/resume cycle at the console (as opposed to from X).  This does
not occur if I first boot to runlevel 1 and then switch to the desired
runlevel - perhaps it is some sort of timing issue?  Very puzzling.

Thanks
Alan

