Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265313AbVBDWYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265313AbVBDWYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbVBDWU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:20:59 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:29065 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264420AbVBDWHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:07:10 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.61954.289521.334673@tut.ibm.com>
Date: Fri, 4 Feb 2005 16:06:58 -0600
To: Christoph Hellwig <hch@infradead.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 3
In-Reply-To: <20050204213909.GA26241@infradead.org>
References: <16899.55393.651042.627079@tut.ibm.com>
	<20050204213909.GA26241@infradead.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > in the filesystem path especially relayfs_create_entry and the functions
 > called by it seem overly complex, probably because copying from ramfs
 > which allows namespace operations from userland.  See the totally untested
 > code below for how it could be done more cleanly.

Thanks, I'll do some simplification as you suggest.

 > 
 > What I really dislike is the code for automatically creating complex
 > hiearchies.  What kinds of hierachies does LTT use?  It shouldn't be
 > more than subsystem/{stream1, stream2, ..., streamN}, right?  In that
 > case I think we could leave it to the user to take of that himself.
 > 

Yeah, I was debating whether to keep that code or just export a
creat_subdir() function instead, which I think I'll do after all.  ltt
doesn't really doesn't need much of a hierarchy beyond ltt/ or maybe
one more deep e.g. ltt/trace ltt/flight, and I doubt many other
applications would either.

Tom


