Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbWAaWP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWAaWP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWAaWP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:15:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4045 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751679AbWAaWP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:15:58 -0500
Date: Tue, 31 Jan 2006 17:15:42 -0500
From: Dave Jones <davej@redhat.com>
To: Chris Mason <mason@suse.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16rc1-git4 slab corruption.
Message-ID: <20060131221542.GC29937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Mason <mason@suse.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060131180319.GA18948@redhat.com> <200601311408.35771.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601311408.35771.mason@suse.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 02:08:35PM -0500, Chris Mason wrote:
 > On Tuesday 31 January 2006 13:03, Dave Jones wrote:
 > > Redzone: 0x5a2cf071/0x5a2cf071.
 > > Last user: [<ffffffff80181cc0>](free_buffer_head+0x2a/0x43)
 > 
 > Haven't seen this one yet, but we have an assortment of strange bugs on
 > 2.6.16-rc1-git.  What were you doing to trigger it?

Running fetchmail/procmail/spamassassin to pick up ~1000 mails.

 > I've been trying to hammer on things with the slab exerciser below, but haven't had much luck in getting a nice reliable test case.

Manfred had a nice 'check all slabs before they're freed' patch, which might
be worth resurrecting for some tests. It may be that we're corrupting rarely
free'd slabs, making them hard to hit.

		Dave

