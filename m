Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268318AbUHFWtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268318AbUHFWtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 18:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268320AbUHFWtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 18:49:02 -0400
Received: from hera.kernel.org ([63.209.29.2]:56487 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S268318AbUHFWsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 18:48:50 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Fri, 6 Aug 2004 22:47:46 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cf11qi$hjm$1@terminus.zytor.com>
References: <200408061018.i76AIdmV005276@burner.fokus.fraunhofer.de> <20040806175937.GA296@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1091832466 18039 127.0.0.1 (6 Aug 2004 22:47:46 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 6 Aug 2004 22:47:46 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040806175937.GA296@ucw.cz>
By author:    Vojtech Pavlik <vojtech@suse.cz>
In newsgroup: linux.dev.kernel
> > 
> > If you do not fix this, you just verify that Linux does not like it's users.
> > Linux users like to call cdrecord -scanbus and they like to see _all_ SCSI 
> > devices from a single call to cdrecord. The fact that the Linux kernel does not
> > return instance numbers for /dev/hd* SCSI devices makes it impossible to
> > implement a unique address space :-(
>  
> I'm a long time Linux and cdrecord user, and I must say I always hated
> the -scanbus thingy. It's so much easier to just pass the /dev/hdc
> device node, where I _know_ my CD burner lives than to have to figure
> out what fake SCSI address cdrecord has made up and requires me to pass
> to it, even when I have just a single CD burner in my system.
> 

Indeed.  To a first order it doesn't matter if the default system
namespace is crappy -- applications inventing its own namespaces
(usually inconsistently) means that it's IMPOSSIBLE to make all
applications do the same thing - which is actually more important to
make them all do "the right thing."  Furthermore, it blocks
improvements such as udev.

Note there is nothing that says cdrecord -scanbus can't print out
a list, using the system device names.

	-hpa



