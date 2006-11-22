Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967016AbWKVCPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967016AbWKVCPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 21:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967018AbWKVCPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 21:15:49 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:2429 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S967016AbWKVCPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 21:15:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=eX1qME3VqEThtLLLlvkq32IU4b0YIhKB47J1nh1mnyUxVxkBybC87HeJS0tZVZXlPmwisYVmrWgxVkrUx6MclGs0EuQ1qJJN0s00yDX7KuWEnomDcHJmjcTpAh2GgenMwtO9KLD4fRUf1nnzMIvwd297iSpzkPP36n2eIHqp6Hw=  ;
X-YMail-OSG: Ns8bcO0VM1mMfFTT2co3n8WtZEtFj.atwqfBOvzQCoMOmOdE2Fv880vrHWcDOnZktuNLWrQayvFT.2csoUoFOMAi.P2hdUGkHA4x3z_XLFN7ZTu8JgalPA--
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.19-rc6 6/6] rtc-omap driver
Date: Tue, 21 Nov 2006 18:15:42 -0800
User-Agent: KMail/1.7.1
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tony Lindgren <tony@atomide.com>
References: <200611201014.41980.david-b@pacbell.net> <200611201028.48701.david-b@pacbell.net> <20061121171906.5eec32d6.akpm@osdl.org>
In-Reply-To: <20061121171906.5eec32d6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211815.43929.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 5:19 pm, Andrew Morton wrote:
> On Mon, 20 Nov 2006 10:28:48 -0800

> > +		/* sometimes the alarm wraps into tomorrow */
> > +		if (then < now) {
> 
> This isn't wraparound-safe.  If you have then=0xffffffff and now=0x00000001.
> 
> Perhaps that can't happen.

Starting in 2037 or whenever, various things will be breaking...

Probably the RTC lib routines should use a time_t, and when that gets
changed to 64 bits then things like this will be fixed automagically.
Right now they use "unsigned long".

I suggest Alessandro handle those issues.


> > +MODULE_AUTHOR("George G. Davis (and others)");
> 
> Maybe some additional signoffs would be appropirate?

I pinged the MontaVista emails from the original driver; maybe
they'll send signoffs.

- Dave
 
