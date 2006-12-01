Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161363AbWLAVBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161363AbWLAVBQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161382AbWLAVBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:01:15 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:24279 "EHLO
	adelie.ubuntu.com") by vger.kernel.org with ESMTP id S1161363AbWLAVBN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:01:13 -0500
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
From: Ben Collins <ben.collins@ubuntu.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Eric Piel <eric.piel@tremplin-utc>
In-Reply-To: <1165002345.3233.104.camel@laptopd505.fenrus.org>
References: <1164998179.5257.953.camel@gullible>
	 <20061201185657.0b4b5af7@localhost.localdomain>
	 <1165001705.5257.959.camel@gullible>
	 <1165002345.3233.104.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Dec 2006 16:01:08 -0500
Message-Id: <1165006868.5257.972.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 20:45 +0100, Arjan van de Ven wrote:
> On Fri, 2006-12-01 at 14:35 -0500, Ben Collins wrote:
> > What about the point that userspace (udev, and such) is not available
> > when DSDT loading needs to occur? Init hasn't even started at that
> > point.
> 
> that's a moot point; you need to load firmware from the initramfs ANYWAY
> for things like qlogic and others...

I don't see how that relates. The DSDT needs to be loaded even before
driver initialization begins. Things like qlogic can over come this by
being compiled as modules, and letting initramfs-tools take care of
things.

That's not the case for DSDT loading. I'm not saying this patch is the
epitome of good coding, just that it's a needed feature.

If there's a better way to do it, I'm volunteering to do the grunt work,
but I haven't heard of any alternatives to this solution.
