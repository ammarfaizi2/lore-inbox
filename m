Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbTDKNZ0 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 09:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbTDKNZ0 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 09:25:26 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:47744 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263654AbTDKNZZ (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 09:25:25 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304111339.h3BDdcDR000919@81-2-122-30.bradfords.org.uk>
Subject: Re: kernel support for non-English user messages
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 11 Apr 2003 14:39:38 +0100 (BST)
Cc: Riley@Williams.Name (Riley Williams),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1050063394.14153.16.camel@dhcp22.swansea.linux.org.uk> from "Alan Cox" at Apr 11, 2003 01:16:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  1. If the printk() messages are internationalised, we are going to
> >     see log extracts posted here in various languages, including some
> >     that the relevant maintainers don't understand. To stand any
> >     realistic chance of dealing with the resultant bug reports, we
> >     need to include the message code in the report so we can just
> >     feed the various reports through a tool that translates them into
> >     our preferred language.
> 
> Providing the viewer is translating the originals always exist. Indeed
> you can do
> 
> 	LANG=es view-logs
> 	LANG=ru view-logs
> 	...
> 
> You can have sysadmins with no common language("not a recommended
> configuration" ;))
> 
> You are right about needing to log parameters, but given a log line
> of the form
> 
> %s: went up in flames\n\0eth0\0\0
> 
> that can be handled by the log viewer

Wouldn't we be better off just more fully documenting the English
error messages, though, and possibly translating that explaination
document in to as many languages as possible?  A lot of people search
for error messages strings in the LKML archives, and variations of the
same string will hinder this.

On a related note, if we are going to make a dmesg interpreter and
translator, could we include the ability to generate a kernel .config
from the boot time output?  Note, I don't mean re-create the .config
that the kernel was compiled with, but something like NetBSD, (at
least), which lets you boot with a kernel that has drivers that you
don't need, and generate a config file which will compile a kernel
which contains only those that are actually needed.

John.
