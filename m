Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTD2XuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 19:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbTD2XuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 19:50:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5064 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261916AbTD2XuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 19:50:17 -0400
Date: Wed, 30 Apr 2003 01:02:36 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KernelJanitor: Convert remaining error returns to return -E Linux 2.5.68
Message-ID: <20030430000236.GS10374@parcelfarce.linux.theplanet.co.uk>
References: <20030429161128.3b8c762b.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030429161128.3b8c762b.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 04:11:28PM -0700, Randy.Dunlap wrote:
> On Tue, 29 Apr 2003 23:08:30 +0000 Gabriel Devenyi <devenyga@mcmaster.ca> wrote:
> 
> | Thanks for the suggestions, I'm kinda new at this and just following the TODO 
> | which unfortuately says "sed s/return EWHATEVER/return -EWHATEVER/". I'll 
> | work on checking the things you suggested. As for your other questions, the 
> | kernel did build but I didn't attempt to boot it, I'll be sure to do so in 
> | the future. Thanks for the encouragement.
> | 
> | P.S. Anyone who works on KernelJanitor, kj.pl is suggesting some of the things 
> | I'm changing which aparently I shouldn't.
> 
> 
> The kernel-janitor TODO should be your guide.  However, it needs some
> updating too, so the best thing to do is ask about things on
> kernel-janitor-discuss@lists.sf.net before you spend time on them.
> 
> [item updates are welcome]

Well...  Turn that one into
	* try and convince XFS folks that they want to use negative numbers
for error values (will be tricky - they really don't like to diverge from
IRIX codebase)
	* ditto for JFS - again, a bunch of functions use positive error
values.
	* oprofile init on alpha should be returning negative in case of
failure to follow the common conventions.

AFAICS that's it.
