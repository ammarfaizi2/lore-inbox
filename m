Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272259AbTHDVaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272261AbTHDVaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:30:24 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:61171 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S272259AbTHDVaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:30:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Stephan von Krawczynski <skraw@ithnet.com>,
       Brian Pawlowski <beepy@netapp.com>
Subject: Re: FS: hardlinks on directories
Date: Mon, 4 Aug 2003 16:29:50 -0500
X-Mailer: KMail [version 1.2]
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
References: <20030804134415.GA4454@win.tue.nl> <200308041542.h74Fg9k26251@orbit-fe.eng.netapp.com> <20030804175609.7301d075.skraw@ithnet.com>
In-Reply-To: <20030804175609.7301d075.skraw@ithnet.com>
MIME-Version: 1.0
Message-Id: <03080416295003.04444@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 August 2003 10:56, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 08:42:09 -0700 (PDT)
>
> Brian Pawlowski <beepy@netapp.com> wrote:
> > I'm still waking up, but '..' obviously breaks the "no cycle"
> > observations.
>
> Hear, hear ...
>
> > It's just that '..' is well known name by utilities as opposed
> > to arbitrary links.
>
> Well, that leads only to the point that ".." implementation is just lousy
> and it should have been done right in the first place. If there is a need
> for a loop or a hardlink (like "..") all you have to have is a standard way
> to find out, be it flags or the like, whatever. But taking the filename or
> anything not applicable to other cases as matching factor was obviously
> short-sighted.

Has nothing to do with the loop. It is called an AVL tree.

It makes the namei lookup function extreemly simple to implement:
"../file" is treated in the same way as "./file" is treated, which
is the same as "file". No special case required. It allows the VERY
flexable (and simple) relative path name handling.
