Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbUBPE13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 23:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUBPE13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 23:27:29 -0500
Received: from [203.94.74.174] ([203.94.74.174]:6007 "EHLO
	ENETSLMAILI.enetsl.Virtusa.com") by vger.kernel.org with ESMTP
	id S265367AbUBPE11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 23:27:27 -0500
Subject: Re: Implementing SQL on files
From: Anuradha Ratnaweera <anuradha@linux.lk>
To: Hans Reiser <reiser@namesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <402F061F.5040301@namesys.com>
References: <1076773002.20087.42.camel@aratnaweera.enetsl.virtusa.com>
	 <402F061F.5040301@namesys.com>
Content-Type: text/plain
Organization: Lanka Linux User Group
Message-Id: <1076905629.10307.27.camel@aratnaweera.enetsl.virtusa.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 10:27:09 +0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2004 04:26:38.0450 (UTC) FILETIME=[11C43D20:01C3F445]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-15 at 11:39, Hans Reiser wrote:
>
> I hate SQL but I will cooperate with persons seeking to use our storage 
> layer to support it.

Thanks Hans.  I am not an SQL fan either.  But more than SQL this
is about database like storage simantics in the filesystem. I had
this idea in my mind for some time, but the real motivation came
after seeing the Reiserfs 4 page, notably this section:

http://www.namesys.com/v4/v4.html#design_flaws_details

and hopefully the plugin design will make life much easier.

By looking at the feedback I got off the list, I think there is a
couple of points I need to clarify.

o The plan is _not_ to implement a fully flegded database inside
  the kernel.  Only the storage (well, "only" may not be the most
  appropriate word here, because this involves a _lot_ of work)
  and the relation operation primitives - or database operation
  primitives to be more general - are implemented in the kernel
  space.

o Userspace tools are necessary to parse a query, optimize if
  necessary, and pass the result (which is a tree) to the kernel.
  And the nodes of the parsed tree will map to the primitives
  implemented in the kernel.

  And most likely, I would be using an exiting database to do the
  heavy userspace work (suggested by Peter Zaitsev of MySQL).

Thanks for all the suggessions and comments (mostly offline).

	Anuradha

-- 

http://www.linux.lk/~anuradha/


