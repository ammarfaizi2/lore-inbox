Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUBWWu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUBWWuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:50:25 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:242 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262070AbUBWWso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:48:44 -0500
Date: Mon, 23 Feb 2004 14:49:11 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       David Wagner <daw@eecs.berkeley.edu>
Subject: Re: &array considered harmful?
Message-ID: <20040223224911.GA48883@gaz.sfgoth.com>
References: <1077574309.16259.4.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077574309.16259.4.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert T. Johnson wrote:
>         memset(&A, 0, sizeof(A)); 
[...]
> This works because in C, for a local array, &A == A.  The problem is
> that this is very brittle.

I'm probably in the minority here, but I've gotten into the habit of saying
"&A[0]" since I think it's more explicit ("I want the address of the
FIRST ELEMENT of the array") and it avoids exactly the problems you mention.
It's true that it's equivelent to just saying "A" (well, almost - if "A"
is a pointer then it could be an lvalue while "&A[0]" never is) but I
like the visual cue of that "&" provides.  Matter of taste I guess -
I'm sure some people consider it ugly.

-Mitch
