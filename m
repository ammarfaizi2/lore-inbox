Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUA2U2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266340AbUA2U2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:28:18 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:41897 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S266220AbUA2U2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:28:10 -0500
From: Matthias Fouquet-Lapar <mfl@kernel.paris.sgi.com>
Message-Id: <200401292016.i0TKGraI034387@mtv-vpn-hw-mfl-2.corp.sgi.com>
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
To: davidm@hpl.hp.com
Date: Thu, 29 Jan 2004 21:16:52 +0100 ("CET)
Cc: mfl@kernel.paris.sgi.com (Matthias Fouquet-Lapar), ak@suse.de (Andi Kleen),
       davidm@napali.hpl.hp.com, iod00d@hp.com, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
In-Reply-To: <16409.24257.589224.818006@napali.hpl.hp.com> from "David Mosberger" at Jan 29, 2004 11:28:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Matthias> We have done a rather large study with DIMMs that had SBEs
>   Matthias> and have found no evidence that a SBE turns into a UCE,
>   Matthias> i.e. the fact that a SBE is reported, is no indication
>   Matthias> that the device might fail soon.
> 
> Ehh, wait a second: you're saying that your study proved that if the
> device isn't failing, it isn't failing. ;-) Of course you'll get noise

I should have been more precice. We used field returned parts which 
had reported SBEs and had been exchanged in the field. Our goal was to
see if any of these parts "de-generate" over time. Most of these parts
had hard single bit failures in one or more locations. As I said,
we didn't find evidence that even hard SBEs turn into a multiple bit
error. Of course the chances of getting a UCE are higher when a "soft"
SBE occurs in a memory location which already has a hard SBE.


Thanks

Matthias Fouquet-Lapar  Core Platform Software    mfl@sgi.com  VNET 521-8213
Principal Engineer      Silicon Graphics          Home Office (+33) 1 3047 4127

