Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270285AbUJTJhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270285AbUJTJhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270262AbUJTJf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 05:35:59 -0400
Received: from almesberger.net ([63.105.73.238]:19984 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S270151AbUJTJ2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:28:06 -0400
Date: Wed, 20 Oct 2004 06:27:32 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] boot parameters: quoting of environment variables revisited
Message-ID: <20041020062732.S18873@almesberger.net>
References: <20041019192336.K18873@almesberger.net> <1098253261.10571.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098253261.10571.129.camel@localhost.localdomain>; from rusty@rustcorp.com.au on Wed, Oct 20, 2004 at 04:21:12PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> If someone passes 'foo="some value"' the param engine removes the
> quotes and hands 'foo' and 'some value'.  The __setup() parameters
> expect a single string, and so we try to regenerate it from the two
> parts.

Ah, that's where the fix in 2.6.9 came from :-) Yes, better to
fix it properly for __setup, too. I didn't even pay attention
to the __setup case, but with that added, this really seems to
want to be done in the parser, perhaps along with "foo=b a r",
or such ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
