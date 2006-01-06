Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbWAFSkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbWAFSkm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932815AbWAFSkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:40:42 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:18651 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932670AbWAFSkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:40:41 -0500
Date: Fri, 6 Jan 2006 13:36:45 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: dual line backtraces for i386.
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601061338_MC3-1-B567-4FDD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060105212802.GR20809@redhat.com>

On Thu, 5 Jan 2006 at 16:28:02 -0500, Dave Jones wrote:

> > Why not:
> > 
> >                         printk(space == 0 ? "     " : "\n");
> >                         space = !space;
>
> readability ?

Well, if I were going for _un_readability I'd have suggested:

        printk(space = !space ? "     " : "\n");

:)

> Personally, I despise the ternary operator, because it makes me
> stop to try to parse it every time I see it.

I think it's a psychological thing because it makes you spend as
much time parsing a single line as it would to parse a whole
if-then-else and it just feels wrong somehow.

> With the code I wrote
> it's blindlingly obvious what is going on.

For simple espressions I think it's about the same, but like you said
it's a personal thing.  A soon as you start nesting cases the 'if'
becomes much clearer.  (People who nest ternary expressions should
be taken out and shot.)
-- 
Chuck
Currently reading: _Thud!_ by Terry Pratchett
