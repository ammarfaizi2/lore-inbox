Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbUCRUQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbUCRUQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:16:37 -0500
Received: from smtp.terra.es ([213.4.129.129]:42310 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S262917AbUCRUQf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:16:35 -0500
Date: Thu, 18 Mar 2004 21:15:32 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Rik van Riel <riel@redhat.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
Message-Id: <20040318211532.293bb63c.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.44.0403181144290.16728-100000@chimarrao.boston.redhat.com>
References: <20040318164253.GO2246@dualathlon.random>
	<Pine.LNX.4.44.0403181144290.16728-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 18 Mar 2004 11:49:52 -0500 (EST) Rik van Riel <riel@redhat.com> escribió:

> I suspect the security paranoid will like this patch too,
> because it allows gnupg to mlock the memory it wants to
> have locked.

I think it's good for cd-burning too. Currently most of the distros set
the suid bit for cdrecord (wich implies some security bugs). You can
workaround that by changing the devide node's permissions and kill the suid bit:
brw-rw----    1 root     burning     22,   0 2003-05-23 16:41 /dev/cd-rw

but still cdrecord will cry:
cdrecord: Operation not permitted. WARNING: Cannot do mlockall(2).
cdrecord: WARNING: This causes a high risk for buffer underruns.

With that patch desktop users will be able to burn cds without falling into
buffer underruns and without using the suid hack, I guess? Nice work :)

	Diego Calleja
