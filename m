Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVGLDGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVGLDGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVGLDGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:06:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:21927 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261841AbVGLDGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:06:12 -0400
Date: Mon, 11 Jul 2005 20:05:56 -0700
From: Greg KH <greg@kroah.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, karim@opersys.com,
       varap@us.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
Message-ID: <20050712030555.GA1487@kroah.com>
References: <17107.6290.734560.231978@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17107.6290.734560.231978@tut.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 08:10:42PM -0500, Tom Zanussi wrote:
> 
> Hi Andrew, can you please merge relayfs?  It provides a low-overhead
> logging and buffering capability, which does not currently exist in
> the kernel.
> 
> relayfs key features:
> 
> - Extremely efficient high-speed logging/buffering
> - Simple mechanism for user-space data retrieval
> - Very short write path
> - Can be used in any context, including interrupt context
> - No runtime resource allocation
> - Doesn't do a kmalloc for each "packet"
> - No need for end-recipient
> - Data may remain buffered whether it is consumed or not
> - Data committed to disk in bulk, not per "packet"
> - Can be used in circular-buffer mode for flight-recording

What ever happened to exporting the relayfs file ops, and just using
debugfs as your controlling fs instead?  As all of the possible users
fall under the "debug" type of kernel feature, it makes more sense to
confine users to that fs, right?

thanks,

greg k-h
