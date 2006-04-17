Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWDQBQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWDQBQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 21:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWDQBQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 21:16:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43199 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750896AbWDQBQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 21:16:56 -0400
Date: Sun, 16 Apr 2006 20:16:42 -0500
From: Dave Jones <davej@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Improve PCI config space writeback.
Message-ID: <20060417011642.GA2495@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060416224215.GA732@redhat.com> <1145233627.9833.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145233627.9833.19.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 10:27:07AM +1000, Ben Herrenschmidt wrote:
 > On Sun, 2006-04-16 at 17:42 -0500, Dave Jones wrote:
 > > At least one laptop blew up on resume from suspend with a black screen
 > > due to a lack of this patch.  By only writing back config space that
 > > is different, we minimise the possibility of accidents like this.
 > > 
 > > Signed-off-by: Dave Jones <davej@redhat.com>
 > 
 > I think it's a mistake to restore the command register before the rest.
 > It should be restored last.

Adam Belay had a patch that did this, and a bunch of other similar
things (like making sure we never set BIST when restoring).

There are likely a number of similar possible improvements.

		Dave

-- 
http://www.codemonkey.org.uk
