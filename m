Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWCWDCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWCWDCK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWCWDCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:02:09 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:56966 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S932526AbWCWDCI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:02:08 -0500
From: Francesco Biscani <biscani@pd.astro.it>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: ACPI error in 2.6.16 (AE_TIME, Returned by Handler for EmbeddedControl)
Date: Thu, 23 Mar 2006 04:01:58 +0100
User-Agent: KMail/1.9.1
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, "Yu, Luming" <luming.yu@intel.com>,
       Jiri Slaby <slaby@liberouter.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30067BF1BC@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30067BF1BC@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603230401.58507.biscani@pd.astro.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 02:45, Brown, Len wrote:
> does this go away if you boot with "ec_intr=0"?

So far it seems like that option solves the problem. But since the bug appears 
very erratically I think it's better to wait for a few more reboots.

BTW, when I was testing _without_ ec_intr=0 I got this in the log (this 
happened the first reboot after the one mentioned in my previous mail):

Mar 23 03:48:50 kurtz ACPI: read EC, IB not empty
Mar 23 03:48:50 kurtz ACPI: read EC, OB not full
Mar 23 03:48:50 kurtz ACPI Exception (evregion-0409): AE_TIME, Returned by 
Handler for [EmbeddedControl] [20060127]
Mar 23 03:48:50 kurtz ACPI Exception (dswexec-0458): AE_TIME, While resolving 
operands for [AE_NOT_CONFIGURED] [20060127]
Mar 23 03:48:50 kurtz ACPI Error (psparse-0517): Method parse/execution failed 
[\_SB_.PCI0.ISA_.EC0_._Q20] (Node c13ecbc0), AE_TIME

This is an hp pavilion ze5616ea laptop, FYI.

Thanks and best regards,

  Francesco

-- 
Dr. Francesco Biscani
Dipartimento di Astronomia
Università di Padova
biscani@pd.astro.it
