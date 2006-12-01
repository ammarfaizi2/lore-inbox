Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162031AbWLAVtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162031AbWLAVtM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162037AbWLAVtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:49:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60862 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1162031AbWLAVtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:49:09 -0500
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
From: Arjan van de Ven <arjan@infradead.org>
Reply-To: arjan@infradead.org
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Eric Piel <eric.piel@tremplin-utc>
In-Reply-To: <1165006868.5257.972.camel@gullible>
References: <1164998179.5257.953.camel@gullible>
	 <20061201185657.0b4b5af7@localhost.localdomain>
	 <1165001705.5257.959.camel@gullible>
	 <1165002345.3233.104.camel@laptopd505.fenrus.org>
	 <1165006868.5257.972.camel@gullible>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 01 Dec 2006 22:49:06 +0100
Message-Id: <1165009747.3233.108.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 16:01 -0500, Ben Collins wrote:
> On Fri, 2006-12-01 at 20:45 +0100, Arjan van de Ven wrote:
> > On Fri, 2006-12-01 at 14:35 -0500, Ben Collins wrote:
> > > What about the point that userspace (udev, and such) is not available
> > > when DSDT loading needs to occur? Init hasn't even started at that
> > > point.
> > 
> > that's a moot point; you need to load firmware from the initramfs ANYWAY
> > for things like qlogic and others...
> 
> I don't see how that relates. The DSDT needs to be loaded even before
> driver initialization begins. 

in fact it needs to be loaded even before the ACPI engine starts
executing, otherwise you're hot-replacing code underneath a live
system...  at which point you can do this same feature in another way :)
there already is a feature that builds a dsdt into the kernel image, all
a distro would need is a bit of objcopy magic to build the right one
into the vmlinuz...



