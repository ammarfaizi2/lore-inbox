Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273298AbTHKUVa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273403AbTHKUVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:21:30 -0400
Received: from fmr03.intel.com ([143.183.121.5]:46556 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S273298AbTHKUVY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:21:24 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
x-mimeole: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [Dri-devel] Re: [PATCH] CodingStyle fixes for drm_agpsupport
Date: Mon, 11 Aug 2003 13:21:22 -0700
Message-ID: <A98078D7EF5BEA4D8D8FD797FFBBC75F0453FCEA@fmsmsx402.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Dri-devel] Re: [PATCH] CodingStyle fixes for drm_agpsupport
Thread-Index: AcNgQYU6e5g2q3aDSCy6yclYVw1o0AAAwzug
From: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
To: <dri-devel@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Aug 2003 20:21:22.0288 (UTC) FILETIME=[21857F00:01C36046]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> if (!pointer) {
>	return (whatever);
> }
>
>
>because it's consistent, and guaranteed safe from stupid
>parsing errors that can waste days of debug time when
>someone decides to add to it.
>("its just a little change that cant hurt anything", ha ha)

I've always been an "Always use brackets" evangelist for two
reasons.
1) The time it takes to write the code fragment is noise
compared to the amount of cumulative time that everyone else
will spend reading it over it's lifespan. This is more true
in open source than it ever was in the closed source world.
Making the code explicit saves everyone time in the longrun.

2) There are some very real ways that bracketless code will
get broken. Either someone adds a line that didn't notice the
lack of brackets or, someone accidentally uses a multi-line
macro.

i.e.
   if(foo)
     DEBUG_PRINT("Foo!\n");

works great for 100 years until someone recodes the DEBUG_PRINT
macro to be 2 lines. The Linux kernel often has plain looking
functions or variables that end up being macros (and may only
expand to multi-line on some platforms) which could easily get
you into such a situation.



