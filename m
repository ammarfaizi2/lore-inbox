Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVD2TtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVD2TtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVD2TtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:49:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:33157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262913AbVD2TtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:49:03 -0400
Date: Fri, 29 Apr 2005 12:50:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Sean <seanlkml@sympatico.ca>, linux-kernel <linux-kernel@vger.kernel.org>,
       git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
In-Reply-To: <20050429191207.GX21897@waste.org>
Message-ID: <Pine.LNX.4.58.0504291248210.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1>
 <20050429074043.GT21897@waste.org> <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
 <20050429163705.GU21897@waste.org> <Pine.LNX.4.58.0504291006450.18901@ppc970.osdl.org>
 <20050429191207.GX21897@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Apr 2005, Matt Mackall wrote:
> 
> Here's an excerpt from http://selenic.com/mercurial/notes.txt on how
> the back-end works.

Any notes on how you maintain repository-level information?

For example, the expense in BK wasn't the single-file history, it was the
_repository_ history, ie the "ChangeSet" file. Which grows quite slowly,
but because it _always_ grows, it ends up being quite big and expensive to
parse after three years.

Ie do you have the git kind of "independent trees/commits", or do you 
create a revision history of those too?

		Linus
