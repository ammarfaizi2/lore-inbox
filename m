Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWBEHBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWBEHBf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 02:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWBEHBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 02:01:35 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:50187 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S964919AbWBEHBe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 02:01:34 -0500
Date: Sun, 5 Feb 2006 09:00:28 +0200
From: Gleb Natapov <gleb@minantech.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: yipee <yipeeyipeeyipeeyipee@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: changing physical page
Message-ID: <20060205070027.GA11558@minantech.com>
References: <loom.20060202T160457-366@post.gmane.org> <Pine.LNX.4.61.0602021711110.8796@goblin.wat.veritas.com> <loom.20060204T152816-726@post.gmane.org> <Pine.LNX.4.61.0602041518230.8867@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602041518230.8867@goblin.wat.veritas.com>
X-OriginalArrivalTime: 05 Feb 2006 07:01:23.0655 (UTC) FILETIME=[F99A1570:01C62A21]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 03:20:00PM +0000, Hugh Dickins wrote:
> On Sat, 4 Feb 2006, yipee wrote:
> > Hugh Dickins <hugh <at> veritas.com> writes:
> > > I'll assume that when you say "page owned by a user program", you're
> > > meaning a private page, not a shared file page mapped into the program.
> > > 
> > > If you're asking about what currently happens, the answer is "No".
> > > 
> > > If you're asking about what you can assume, the answer is "Yes".
> > 
> > So you are saying that the current kernel doesn't move these kind of pages?
> 
> If you don't have swap (one of the conditions you gave), yes.
> 
And what if application forks and writes to the private page? Kernel
actually memcpy the page to another location.

--
			Gleb.
