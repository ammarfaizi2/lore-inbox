Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263164AbVCXTJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbVCXTJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbVCXTJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:09:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32680 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263164AbVCXTJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:09:51 -0500
Subject: Re: ext3 journalling BUG on full filesystem
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Mark Wong <markw@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050324103945.GF19394@atrey.karlin.mff.cuni.cz>
References: <20050323202130.GA30844@osdl.org>
	 <20050323221753.GA6334@cse.unsw.EDU.AU>
	 <20050324103945.GF19394@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111691379.1995.91.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 24 Mar 2005 19:09:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2005-03-24 at 10:39, Jan Kara wrote:

>   Actually the patch you atached showed in the end as not covering all
> the cases and so Stephen agreed to stay with the first try (attached)
> which should cover all known cases (although it's not so nice).

Right.  The later patch is getting reworked into a proper locking
overhaul for the journal_put_journal_head() code.  The earlier one (that
Jan attached) is the one that's appropriate in the mean time; it covers
all of the holes we know about for sure and has proven robust in
testing.

--Stephen

