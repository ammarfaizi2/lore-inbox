Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUIAN7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUIAN7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUIAN7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:59:54 -0400
Received: from cheddar.cendio.se ([193.12.253.77]:10744 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S266648AbUIAN72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:59:28 -0400
Date: Wed, 1 Sep 2004 15:59:24 +0200 (CEST)
From: Peter Astrand <peter@cendio.se>
X-X-Sender: peter@maggie.lkpg.cendio.se
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: ncpfs problems
In-Reply-To: <2505C593E0E@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0409011555010.29446-100000@maggie.lkpg.cendio.se>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > * Some files are impossible to remove, for example the files in 
> > ~/.kde/socket-dhcp-253-234: An unlink returns EBUSY:
> > 
> > unlink("kdeinit_maggie_2")              = -1 EBUSY (Device or resource busy)
> > 
> > Do you have any ideas what can cause this? Do you consider ncpfs stable
> > enough to be used for the home directory? 
> 
> File is open... You cannot remove opened files from Netware filesystem.
> I cannot think about any other reason why you should get EBUSY.

It might have something to do with open files, but in that case, the
behaviour is not consistent. I've just did a quick test with "cat
> foo.txt", and was able to delete the file while it was still open:

# ls -l /proc/21642/fd
...
l-wx------  1 adam 1000 64 Sep  1 15:39 1 -> /home/adam/foo.txt (deleted)
...

I'm using 2.6.8.1. 


(Please CC me on this topic.)

Regards, Peter


