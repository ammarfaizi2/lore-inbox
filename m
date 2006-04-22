Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWDVAXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWDVAXp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 20:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWDVAXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 20:23:45 -0400
Received: from ns2.suse.de ([195.135.220.15]:37323 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750782AbWDVAXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 20:23:44 -0400
Date: Fri, 21 Apr 2006 17:19:14 -0700
From: Tony Jones <tonyj@suse.de>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-audit@redhat.com, Amy Griffis <amy.griffis@hp.com>,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 9/11] security: AppArmor - Audit changes
Message-ID: <20060422001914.GA9257@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175018.29149.391.sendpatchset@ermintrude.int.wirex.com> <20060421212109.GB1903@zk3.dec.com> <200604212013.52374.sgrubb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604212013.52374.sgrubb@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 08:13:52PM -0400, Steve Grubb wrote:
> On Friday 21 April 2006 17:21, Amy Griffis wrote:
> > linux-audit (cc'd) will likely want to review these changes.
> 
> Yes, I second that. Tony, please cc audit patches to linux-audit mail list so 
> we can see them. That said, I did tell Tony they could use message type 
> numbers 1500 - 1600 for AppArmor if they need it.

Sorry, I thought I'd bounced this one patch in the series to the audit list.
I meant to. One more thing lost in the noise.  Apologies.

1500 should already be reserved for apparmor userside.  Only change is to 
enable it kernelside plus of course the one more symbol export to bloat the 
kernel image.  Export of the vformat call is to make it analagous to vprintk.  
Sometimes it's more convenient to have a single point of logging (as we do)
and you need to log data which is in va_list format.

Tony
