Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVCCBcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVCCBcp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVCCBcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:32:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42436 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261295AbVCCBaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:30:25 -0500
Date: Wed, 2 Mar 2005 17:55:44 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>,
       Vasily Averin <vvs@sw.ru>, Matt Domsch <Matt_Domsch@dell.com>,
       linux-kernel@vger.kernel.org, "Mukker, Atul" <Atulm@lsil.com>
Subject: Re: v2.4 megaraid2 update Re: [PATCH] Prevent NMI oopser
Message-ID: <20050302205544.GB4100@logos.cnet>
References: <0E3FA95632D6D047BA649F95DAB60E570230CBEC@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CBEC@exa-atlanta>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 11:26:06AM -0500, Bagalkote, Sreenivas wrote:
> Hello Marcelo,

Hi Sreenivas,

Damn, now I apologize for taking so long to answer... 

> As per our offline conversation, I have verified the update that went into
> 2.4.30-pre2.
> I confirm that all changes are correct. I have only one doubt: The driver
> was using
> sleep_on_timeout  for lack of msleep. Should it start using msleep now?

I dont see the need for msleep() given that sleep_on_timeout() schedules.

The problematic EH code which used udelay() was removed AFAICS.

> Vasily & Andrey, thank you for your efforts.

I appreciate your offline message that you're compromised to 
keep an eye on v2.4 megaraid2 from now on :) 
