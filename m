Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422769AbWJaBDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbWJaBDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 20:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161514AbWJaBDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 20:03:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:36853 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161497AbWJaBDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 20:03:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=edmbeHOxR6zj6j3SUUjKBx517CsjSKBTV79JdGQ2T+5AngspFEzowVoH1MTqHpwVzS6eHTgewANsoFsd4MAy/YSJIGeKW5nZvi+yxb/q4Ho7wFVhmO6IadiTIknyMaPy+DHcj+RfLhQwBqiK9QOBkfpVFDQq2/BOyDm/nnrbuLo=
Message-ID: <d512a4f30610301703r68dfa848s116475b68435f136@mail.gmail.com>
Date: Tue, 31 Oct 2006 02:03:02 +0100
From: "Sylvain Bertrand" <sylvain.bertrand@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [Bugme-new] [Bug 7437] New: VIA VT8233 seems to suffer from the via latency quirk
Cc: linux-kernel@vger.kernel.org, "Greg KH" <greg@kroah.com>,
       "Chris Wedgwood" <cw@f00f.org>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>
In-Reply-To: <20061030163458.4fb8cee1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610310020.k9V0KGQK003237@fire-2.osdl.org>
	 <20061030163458.4fb8cee1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, this has always happened since kernel 2.4 from years
back, even with USB1 devices and I had to drop software raid 0.
As far as I understand the quirk code, it's not enabled for the VT8233
southbridge.
I can add the PCI ID of this VT8233 for this quirk code, if it's
compatible, and do some crash tests. Crashes are usually easy to
produce and not hardware destructive since I got plenty of them. But
you may want to proceed in another way.

2006/10/31, Andrew Morton <akpm@osdl.org>:
>
> (switched to email - please retain all cc's)
>
> On Mon, 30 Oct 2006 16:20:16 -0800
> bugme-daemon@bugzilla.kernel.org wrote:
>
> > http://bugzilla.kernel.org/show_bug.cgi?id=7437
> >
> >            Summary: VIA VT8233 seems to suffer from the via latency quirk
> >     Kernel Version: 2.6.19-rc3
> >             Status: NEW
> >           Severity: normal
> >              Owner: greg@kroah.com
> >          Submitter: sylvain.bertrand@gmail.com
> >
> >
> > Most recent kernel where this bug did not occur: 2.6.19-rc3
>
> Nope.  We're asking which kernel did _not_ have this bug?
>
> > Distribution: All
> > Hardware Environment: ASUS A7V266-E motherboad (northbridge VIA KT266A,
> > southbridge VIA 8233), PCI SB LIVE!, onboard promise IDE controller, additional
> > PCI USB2 card.
> > Software Environment: any
> >
> > Problem Description: Fear to load the PCI bus, because it seems to cause a hard
> > crash with hard drive data corruption. Too much similar to quirk_vialatency in
> > drivers/pci/quirks.c (see description line 163) to be innocent.
> >
> > Steps to reproduce: Load the PCI bus with, for instance, a big file transfer
> > from an usb mass storage media v2 connected on a PCI USB2 card to the main hard
> > drive and at the same time play music. Randomly crashes the computer and
> > corrupts hard drive data (sometimes beyond repair).
> >
>
> argh.  Are you able to identify a change to the via quirk-handling code
> which prevents this from happening?
>
>
