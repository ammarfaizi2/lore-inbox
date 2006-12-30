Return-Path: <linux-kernel-owner+w=401wt.eu-S1030273AbWL3E5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWL3E5g (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 23:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWL3E5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 23:57:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48500 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030273AbWL3E5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 23:57:35 -0500
Date: Fri, 29 Dec 2006 23:57:13 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Print sysrq-m messages with KERN_INFO priority
Message-ID: <20061230045713.GA10694@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
References: <E1H0Uq5-0003Fo-1W@candygram.thunk.org> <20061229204247.be66c972.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229204247.be66c972.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
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

I looked at this and got even more puzzled.
__handle_sysrq temporarily sets the loglevel to 7 (KERN_DEBUG) for the
duration of the sysrq-<whatever> output.

Which is odd, as KERN_DEBUG stuff is usually hidden, yet the
printk's that lack loglevels still seem to end up onscreen.

Ted's patch also misses a few of the printk's in show_free_areas()
which seems inconsistent, or am I just confused?

		Dave

-- 
http://www.codemonkey.org.uk
