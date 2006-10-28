Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752032AbWJ1JwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbWJ1JwA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 05:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbWJ1Jv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 05:51:59 -0400
Received: from ns1.suse.de ([195.135.220.2]:36002 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752032AbWJ1Jv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 05:51:59 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: AMD X2 unsynced TSC fix?
Date: Sat, 28 Oct 2006 02:45:55 -0700
User-Agent: KMail/1.9.1
Cc: thockin@hockin.org, Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
References: <1161969308.27225.120.camel@mindpipe> <20061028063524.GA7669@hockin.org> <20061027234615.791b3942.akpm@osdl.org>
In-Reply-To: <20061027234615.791b3942.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610280245.55803.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 October 2006 23:46, Andrew Morton wrote:
> On Fri, 27 Oct 2006 23:35:24 -0700
>
> thockin@hockin.org wrote:
> > On Fri, Oct 27, 2006 at 09:06:12PM -0700, Andi Kleen wrote:
> > > > So far, has I can understand. Seems to me that my computer which have
> > > > a Pentium D (Dual Core) on VIA chipset, also have unsynchronized TSC
> > > > and with the patch of hrtimers on
> > >
> > > Intel systems (except for some large highend systems) have synchronized
> > > TSCs.
> >
> > Does Intel guarantee that, or is that just what we happen to see, so far.
>
> Matthias has a Xeon machine on which the TSCs are unsynced, and which are
> unsyncable - write_tsc() just doesn't do anything.  See thread at
> http://lkml.org/lkml/2006/7/22/104

That is a clear BIOS bug (FSBs are programmed incorrectly) and doesn't seem to 
be common. In fact the BIOS bug is so bad that it's surprising the system
works at all.

-Andi
