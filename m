Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbTIDVk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265593AbTIDVk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:40:29 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41608 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265563AbTIDVkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:40:20 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: jimwclark@ntlworld.com
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Date: Thu, 4 Sep 2003 23:41:22 +0200
User-Agent: KMail/1.5
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0309041628380.14715-100000@chimarrao.boston.redhat.com> <200309042212.25052.jimwclark@ntlworld.com>
In-Reply-To: <200309042212.25052.jimwclark@ntlworld.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309042341.22702.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Heh.  You want stable plugin API.

It will always end as bloat:

(a) you add plugin API
(b) its not sufficient, so you add revision 1 of the API
    (you still have to support rev 0 because some plugins are binary-only)
(c) its not sufficient, so you add revision 2 of the API
    (now you have 3 versions of API to maintain)
...

Alternatively you can start with over-designed API from the beginning :-).

--bartlomiej

On Thursday 04 of September 2003 23:12, James Clark wrote:
> Why would binary drivers be any harder to debug than the existing binary
> kernel. If you want to debug something use the source code. My proposal
> doesn't remove the need for quality public source code but it does isolate
> the kernel components and allow for 'plugin' use on different kernels both
> old and new.
>
> If a relatively small kernel component can be turned on/off and upgraded at
> will, without changing ANYTHING else, this would be a big step forward.
>
> James
>
> On Thursday 04 Sep 2003 9:29 pm, you wrote:
> > On Thu, 4 Sep 2003, James Clark wrote:
> > > I'm very surprised by the number of posts that have ranted about
> > > Open/Close source, GPL/taint issues etc. This is not about source code
> > > it is about making Linux usable by the masses.
> >
> > How would "making it easier to include impossible to debug
> > device drivers" help towards your goal of making Linux more
> > usable ?

