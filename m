Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVG1PvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVG1PvC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVG1PtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:49:24 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:46572 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261570AbVG1Pri convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:47:38 -0400
Subject: [PATCH 0/5] Add kernel AIO support for POSIX AIO
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "linux-aio kvack.org" <linux-aio@kvack.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 28 Jul 2005 17:46:28 +0200
Message-Id: <1122565588.2019.79.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/07/2005 17:59:42,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/07/2005 17:59:44,
	Serialize complete at 28/07/2005 17:59:44
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This set of patches adds functionality to the kernel AIO 
infrastructure to be used by user level libraries aiming at implementing
a POSIX compliant API on top of this kernel support.

  This patchset is comprised of 5 patches, each implementing a specific
functionality:

	- aiomaxevents: adds a sysctl variable for setting the default 
	  AIO context event ring size at runtime. This tunable is 
	  accessible via /proc/sys/fs/posix-aio-default-max-nr.

	- aioevent: adds support for request completion notification.

	- lioevent: adds support for list of requests completion 
	  notification.

	- liowait: adds support for the POSIX listio LIO_WAIT mechanism.

	- cancelfd: adds support for cancellation against a file 
	  descriptor.

 These patches apply cleanly on a vanilla 2.6.12 kernel tree and should 
be applied in the order shown before.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

