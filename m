Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVCXVYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVCXVYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVCXVYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:24:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57477 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261559AbVCXVYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:24:47 -0500
Subject: Re: ext3 journalling BUG on full filesystem
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Jan Kara <jack@suse.cz>, Mark Wong <markw@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050324193834.GH28536@shell0.pdx.osdl.net>
References: <20050323202130.GA30844@osdl.org>
	 <20050323221753.GA6334@cse.unsw.EDU.AU>
	 <20050324103945.GF19394@atrey.karlin.mff.cuni.cz>
	 <1111691379.1995.91.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050324193834.GH28536@shell0.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111699467.1995.94.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 24 Mar 2005 21:24:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2005-03-24 at 19:38, Chris Wright wrote:

> OK, good to know.  When I last checked you were working on a higher risk
> yet more complete fix, and I thought we'd wait for that one to stabilize.
> Looks like the one Jan attached is the better -stable candidate?

Definitely; it's the one I gave akpm.  The lock reworking is going to
remove one layer of locks, so it's worthwhile from that point of view;
but it's longer-term, and I don't know for sure of any paths to chaos
with that simpler journal_unmap_buffer() fix in place.  (It's just very
hard to _prove_ all cases are correct without the locking rework.)

--Stephen

