Return-Path: <linux-kernel-owner+w=401wt.eu-S932796AbWLNOYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbWLNOYr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932797AbWLNOYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:24:47 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:54965 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932786AbWLNOYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:24:46 -0500
Subject: Re: [PATCH 2.6.20-rc1] ib_verbs: Use explicit if-else statements
	to avoid errors with do-while macros
From: Ben Collins <ben.collins@ubuntu.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <ada4pryq5ts.fsf@cisco.com>
References: <1166065805.6748.135.camel@gullible>
	 <20061214064430.GM4587@ftp.linux.org.uk>
	 <20061214065624.GN4587@ftp.linux.org.uk>  <ada4pryq5ts.fsf@cisco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Dec 2006 09:24:19 -0500
Message-Id: <1166106259.6748.217.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 23:45 -0800, Roland Dreier wrote:
>  > IOW, do ; while(0) / do { } while (0)  is not a proper way to do a macro
>  > that imitates a function returning void.
>  > 
>  > Objections?
> 
> None from me, although the ternary ? : is a pretty odd way to write
> 
> 	if (blah)
> 		do_this_void_function();
> 	else
> 		do_that_void_function();
> 
> so I'm in favor of that half of the patch anyway.  It's my fault for
> not noticing that part of the patch in the first place.
> 
> Changing the non-void ? : constructions is just churn, but there's no
> sense changing it again now that the patch is merged.

The rest of it was just for consistency sake.
