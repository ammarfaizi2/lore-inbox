Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbUAPRVT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 12:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbUAPRVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 12:21:19 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:53644 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265078AbUAPRVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 12:21:17 -0500
Date: Fri, 16 Jan 2004 09:21:00 -0800
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       jeremy@sgi.com
Subject: Re: [PATCH] readX_relaxed interface
Message-ID: <20040116172100.GA13553@sgi.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	jeremy@sgi.com
References: <20040115204913.GA8172@sgi.com> <20040116003224.GF23253@kroah.com> <Pine.LNX.4.58.0401152057380.2631@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401152057380.2631@evo.osdl.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 09:00:10PM -0800, Linus Torvalds wrote:
> If you care about machine check errors, use a special interface for that. 
> A _really_ special one. Especially as on many systems you'll likely have 
> to read status registers etc (and clear them before doing the IO) to see 
> the errors.
> 
> So that way you can get errors working, AND it won't actually make normal 
> code any uglier.

How about one that allows you to register an error handling function for
a given address range and/or device?  That would cover both read() and
write() cases, and would be optional so drivers wouldn't be forced to
become more complicated.

Jesse
