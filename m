Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVKWCMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVKWCMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVKWCMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:12:45 -0500
Received: from fmr24.intel.com ([143.183.121.16]:8868 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932231AbVKWCMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:12:44 -0500
Date: Tue, 22 Nov 2005 18:12:43 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: BUG 2.6.14.2 : ACPI boot lockup
Message-ID: <20051122181242.A5214@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20051122211947.GA29622@bougret.hpl.hp.com> <20051122165429.A30362@unix-os.sc.intel.com> <20051123020609.GA30491@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051123020609.GA30491@bougret.hpl.hp.com>; from jt@hpl.hp.com on Tue, Nov 22, 2005 at 06:06:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 06:06:09PM -0800, Jean Tourrilhes wrote:
> 
> 	This patch does not look right to me, but I must admit I have
> no clue about what the code is doing. Can you confirm you want me to
> try this ?
> 
Yes, please try this since this is known to fix at least a couple
of other machines (see 
https://bugzilla.novell.com/show_bug.cgi?id=116763)

The original acpi code ignored errors related to matching an
acpi device to an acpi driver. I changed that behavior to flag
an error, and this was wrong. An acpi device listed in the
namespace should not be required to have a driver for it to
be added to the acpi list.

thanks,
Rajesh
