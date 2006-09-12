Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWILNge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWILNge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 09:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWILNge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 09:36:34 -0400
Received: from ns1.suse.de ([195.135.220.2]:59801 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030237AbWILNgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 09:36:33 -0400
From: Andi Kleen <ak@suse.de>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] - restore i8259A eoi status on resume
Date: Tue, 12 Sep 2006 14:11:36 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <20060910141533.GA6594@srcf.ucam.org> <20060912091906.GB19482@elf.ucw.cz> <20060912124742.GB31344@srcf.ucam.org>
In-Reply-To: <20060912124742.GB31344@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609121411.36913.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 September 2006 14:47, Matthew Garrett wrote:
> On Tue, Sep 12, 2006 at 11:19:06AM +0200, Pavel Machek wrote:
> > Hi!
> >
> > > Got it. i8259A_resume calls init_8259A(0) unconditionally, even if
> > > auto_eoi has been set. Keep track of the current status and restore
> > > that on resume. This fixes it for AMD64 and i386.
> >
> > Patch looks okay to me...
>
> Cool. Andi, does it look sane to you? I'm not really sure who to wave
> 8259 code at...

Yes. I already have it queued for .19 at least. Not sure it's critical enough 
for .18, especially since it doesn't seem to be a regression.

-Andi
