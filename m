Return-Path: <linux-kernel-owner+w=401wt.eu-S1755257AbXABEhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbXABEhq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 23:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbXABEhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 23:37:46 -0500
Received: from THUNK.ORG ([69.25.196.29]:57292 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755257AbXABEhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 23:37:46 -0500
Date: Mon, 1 Jan 2007 23:37:43 -0500
From: Theodore Tso <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Print sysrq-m messages with KERN_INFO priority
Message-ID: <20070102043743.GB15718@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <E1H0Uq5-0003Fo-1W@candygram.thunk.org> <20061229204247.be66c972.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229204247.be66c972.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 08:42:47PM -0800, Andrew Morton wrote:
> On Fri, 29 Dec 2006 22:24:53 -0500
> "Theodore Ts'o" <tytso@mit.edu> wrote:
> 
> > Print messages resulting from sysrq-m with a KERN_INFO instead of the
> > default KERN_WARNING priority
> 
> hm, I wonder why.  If someone does sysrq-<whatever> then they presumably want
> to display the result?  Tricky.
> 
> Is this patch a consistency thing?

The goal of the patch was to avoid filling /var/log/messages huge
amounts of sysrq text.  Some of the sysrq commands, especially sysrq-m
and sysrq-t emit a truly vast amount of information, and it's not
really nice to have that filling up /var/log/messages.  

						- Ted
