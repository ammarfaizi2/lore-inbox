Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317504AbSFRRMX>; Tue, 18 Jun 2002 13:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317505AbSFRRMW>; Tue, 18 Jun 2002 13:12:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31502 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317504AbSFRRMS>;
	Tue, 18 Jun 2002 13:12:18 -0400
Date: Tue, 18 Jun 2002 18:12:19 +0100
From: Matthew Wilcox <willy@debian.org>
To: george anzinger <george@mvista.com>
Cc: "David S. Miller" <davem@redhat.com>, willy@debian.org, rml@mvista.com,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
Message-ID: <20020618181219.H9435@parcelfarce.linux.theplanet.co.uk>
References: <3D0EACCA.3290139@mvista.com> <20020617.211548.63484157.davem@redhat.com> <3D0F675F.54B87C38@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D0F675F.54B87C38@mvista.com>; from george@mvista.com on Tue, Jun 18, 2002 at 10:01:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 10:01:19AM -0700, george anzinger wrote:
> Could you elaborate on the reason for the above bit of
> code?  Is it to cover some thing from the past or is this an
> on going issue?  I.e. will this disappear soon?  Is its
> usage dependent on a particular driver?

The comment says:
/* Deliver skb to an old protocol, which is not threaded well
   or which do not understand shared skbs.
 */

so it's nothing to do with drivers, but old protocols (like SNA, I guess).

Why did you decide to use a softirq for timers rather than a tasklet?

-- 
Revolutions do not require corporate support.
