Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWGGUYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWGGUYo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 16:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWGGUYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 16:24:44 -0400
Received: from gherkin.frus.com ([192.158.254.49]:10255 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S1751234AbWGGUYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 16:24:44 -0400
Subject: 2.6.18-rc1 build error (YACC): followup
To: linux-kernel@vger.kernel.org
Date: Fri, 7 Jul 2006 15:24:42 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060707202442.DA2AFDBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>$YACC now seems to be undefined when I do a "make bzImage" and the
>build process gets to drivers/scsi/aic7xxx/aicasm (with the aic7xxx
>driver configured as a built-in).  As a workaround, it's possible to
>"cd" into the indicated directory and run "make" directly.  Once the
>default build completes, restarting "make bzImage" from the kernel
>source root continues as expected.

Found it.  The main "Makefile" has "MAKEFLAGS += -rR" uncommented as
of 2.6.18-rc1.  The deleted comment about "possibly random breakage"
that used to be just above that line pretty much says it all :-).

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
