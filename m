Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269987AbUJNHcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269987AbUJNHcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 03:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269985AbUJNHcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 03:32:41 -0400
Received: from palrel12.hp.com ([156.153.255.237]:47071 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S269946AbUJNHci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 03:32:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16750.11146.297875.521746@napali.hpl.hp.com>
Date: Thu, 14 Oct 2004 00:32:26 -0700
To: Arun Sharma <arun.sharma@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT
In-Reply-To: <416DABB9.8050804@intel.com>
References: <41643EC0.1010505@intel.com>
	<20041007142710.A12688@infradead.org>
	<4165D4C9.2040804@intel.com>
	<mailman.1097223239.25078@unix-os.sc.intel.com>
	<41671696.1060706@intel.com>
	<mailman.1097403036.11924@unix-os.sc.intel.com>
	<416AF599.2060801@intel.com>
	<1097617824.5178.20.camel@localhost.localdomain>
	<416C5ECF.6060402@intel.com>
	<416DABB9.8050804@intel.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 13 Oct 2004 15:27:05 -0700, Arun Sharma <arun.sharma@intel.com> said:

  Arun> Arun Sharma wrote:
  >> Christoph doesn't like the idea of adding exec-domains just for
  >> this purpose and has suggested adding a new system call to set
  >> the altroot. A prototype patch to do this already exists. I will
  >> be cleaning it up and posting it to LKML later this week. The
  >> main purpose of moving the discussion to LKML was to see how
  >> receptive people were to the proposed new system call.

  Arun> Attached is the promised patch. It addresses Christoph's
  Arun> comments and fixes the bug Tony found as well.

I like it.  Once it's in (surely it will go in, no? ;-),
we can change asm-ia64/namei.h to define a non-NULL __emul_prefix()
only if CONFIG_IA32_SUPPORT is defined.  One less hardcoded path
to worry about!

	--david
