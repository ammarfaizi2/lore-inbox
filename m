Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTICRT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264125AbTICRSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:18:36 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:48844 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264115AbTICRRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:17:25 -0400
Subject: Re: Kernel 2.4: Load average scaling to 200!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Vanns <jimv@canterbury.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1062605821.23773.15.camel@eeyore.ntnet.cc.local>
References: <1062605821.23773.15.camel@eeyore.ntnet.cc.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062609387.19058.138.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 18:16:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 17:17, James Vanns wrote:
> When using mt on RedHat Linux 8 running kernel 2.4.20 to fsf on an LTO
> tape drive the load average soars to 100+ and denies everyone the mail
> service it's used for (IMAP). I have to reboot the server as I cannot
> kill mt. 

I can think of two possible causes here. #1 is that something hung the
scsi bus because of a crash - be it kernel, mt, hardware whatever. The
other one some people hit with tape drives is that they don't have
disconnect enabled on the drive (check your drive manuals). With
disconnect disabled the tape will hog the bus for the entire time it
is doing a command.  

The tapes I have don't seem to take long enough to fsf (even if they are
past the last marker) to worry too much however.

Do you also get messages about scsi timeouts

What card ?

