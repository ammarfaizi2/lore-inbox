Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbTJYTUi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 15:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbTJYTUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 15:20:38 -0400
Received: from morbo.e-centre.net ([66.154.82.3]:61923 "EHLO
	morbo.e-centre.net") by vger.kernel.org with ESMTP id S262774AbTJYTUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 15:20:31 -0400
Date: Sat, 25 Oct 2003 15:20:19 -0400
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: Swsusp-2.0-2.6-alpha1
Message-ID: <20031025192019.GA1033@iain-vaio-fx405>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1067069558.1975.54.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <1067069558.1975.54.camel@laptop-linux>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.6.0-test8 (i686)
X-Uptime: 15:18:30 up  1:34,  4 users,  load average: 0.54, 0.90, 0.60
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Nigel Cunningham (ncunningham@clear.net.nz) wrote:
> Hi all.
> 
> I'm pleased to be able to announce the first test release of a port of
> the current 2.0 pre-release Software Suspend code to 2.6. 

hurrah!

The attached patch allowed the kernel to compile for me, haven't booted
into it as yet.

thanks Nigel,
iain

-- 
"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -- St. Augustine

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="swsusp.diff"

--- linux-2.6.0-test8-temp/drivers/scsi/scsi_error.c	2003-10-25 15:13:31.000000000 -0400
+++ linux-2.6.0-test8-swsusp/drivers/scsi/scsi_error.c	2003-10-25 14:06:13.000000000 -0400
@@ -1506,7 +1506,7 @@
 
 	daemonize("scsi_eh_%d", shost->host_no);
 
-	current->flags |= PF_IOTHREAD;
+	current->flags |= PF_NOFREEZE;
 
 	shost->eh_wait = &sem;
 	shost->ehandler = current;

--azLHFNyN32YCQGCU--
