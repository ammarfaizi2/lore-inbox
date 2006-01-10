Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWAJPhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWAJPhe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWAJPhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:37:33 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:32085 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932226AbWAJPhd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:37:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G4PqTgK1BCgzfS21LDQ1q/ITiB+o+0kyk24AiBloK3vNlSvrB6RPWbZfBDEZ6JiS8mpDA+zP1TaLtgfv54P5k0mp0UPIQC6kvujLkvYNp/Fc/4JTn/1DBv5Ih+08C5a/qBjkITO1lgoevpzQE6ZrNLhtUlerWgzWPpCsGYsvyZQ=
Message-ID: <d120d5000601100737r7b1e12edy6d4eedc4b12960fc@mail.gmail.com>
Date: Tue, 10 Jan 2006 10:37:31 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>,
       linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Leonid <nouser@lpetrov.net>
In-Reply-To: <20060110152807.GB22371@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060110074336.GA7462@suse.cz>
	 <Pine.LNX.4.44L0.0601101008440.5060-100000@iolanthe.rowland.org>
	 <20060110152807.GB22371@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Jan 10, 2006 at 10:12:21AM -0500, Alan Stern wrote:
> > On Tue, 10 Jan 2006, Vojtech Pavlik wrote:
> >
> > > It's usually that the BIOS does an incomplete emulation of the i8042
> > > chip, while still getting in the way to the real i8042. Usually GRUB and
> > > DOS don't care about sending any commands to the i8042, and so they
> > > work. The Linux i8042.c driver needs to use them to enable the PS/2
> > > mouse port and do other probing, and if the commans are not working, it
> > > just bails out.
> > >
> > > The question of course is why the handoff code doesn't work on that
> > > platform.
> >
> > It turned out that a BIOS upgrade fixed the problem, but this doesn't
> > answer your question.
> >
> > The problem wasn't an incomplete emulation of the i8042, because when the
> > USB handoff code was commented out the PS/2 keyboard worked okay.  This
> > means the handoff, when enabled, wasn't being done correctly.  That could
> > be the fault of the USB drivers or the BIOS (or both).  We have no way to
> > tell which, because the users have all switched to the newer BIOS.
>
> As usual with BIOS interaction problems.
>

We'll just have to wait for another report. "Sluggish typing" report
looks promising.

--
Dmitry
