Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbTIEPD1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTIEPD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:03:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:46800 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262634AbTIEPD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:03:26 -0400
Date: Fri, 5 Sep 2003 08:02:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Unpinned futexes v2 - part 1: indexing changes
In-Reply-To: <20030905045738.GA2197@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309050800410.25313-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, applied. However:

On Fri, 5 Sep 2003, Jamie Lokier wrote:
>  
> (The next patch in this series fixes mremap()).

I don't think this one is worth it. If the user unmaps or changes the 
mapping from under the futex, I just think that is "user error". And the 
same way it is totally undefined what happens if one thread re-organizes 
the VM space while another thread may be doing some other operation 
(read() or similar), we just don't care. 

		Linus

