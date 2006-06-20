Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965503AbWFTEG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965503AbWFTEG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 00:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965501AbWFTEG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 00:06:29 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22948
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965500AbWFTEG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 00:06:28 -0400
Date: Mon, 19 Jun 2006 21:06:35 -0700 (PDT)
Message-Id: <20060619.210635.66061007.davem@davemloft.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: mm-commits@vger.kernel.org, randy.dunlap@oracle.com,
       val_henson@linux.intel.com
Subject: Re: + make-tulip-driver-not-handle-davicom-nics.patch added to -mm
 tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <200606200046.k5K0kPdg020414@shell0.pdx.osdl.net>
References: <200606200046.k5K0kPdg020414@shell0.pdx.osdl.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: akpm@osdl.org
Date: Mon, 19 Jun 2006 17:49:48 -0700

> Subject: Make tulip driver not handle Davicom NICs
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> 
> Make tulip driver not handle Davicom NICs, let dmfe take over"
> 
> Reference: https://launchpad.net/bugs/48287
> Source URL of Patch:
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=1804482911a71bee9114cae1c2079507a38e9e7f
> 
> Cc: Valerie Henson <val_henson@linux.intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Please see followups, this change is bogus, it breaks sparc64 Sun
Netra X1 onboard NICs.  The tulip driver drives them fine in that
case, the dmfe driver doesn't work at all.

There is no reason the normal tulip driver cannot handle these
chip variants.
