Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbTIDSqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265488AbTIDSqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:46:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:65000 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265444AbTIDSqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:46:40 -0400
Date: Thu, 4 Sep 2003 11:46:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <20030904183819.GF30394@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309041144110.6676-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Jamie Lokier wrote:
> 
>   * I contend that the user-visible behaviour of a mapping should
>   * _not_ depend on whether the file was opened with O_RDWR or O_RDONLY.

And I violently agree. But I also add the _other_ requirement:

 * I contend that user-visible behaviour of a mapping should be 100% the 
 * same for a unwritable MAP_SHARED and a unwritten MAP_PRIVATE

Put the two together, and see what you get. You get the requirement that 
if MAP_SHARED works, then MAP_PRIVATE also has to work.

That's my requirement. Consistency.

		Linus



