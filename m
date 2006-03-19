Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWCSSE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWCSSE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 13:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWCSSE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 13:04:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39066 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932151AbWCSSE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 13:04:59 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 1/6] prepare sysctls for containers
References: <20060306235248.20842700@localhost.localdomain>
	<20060306235249.880CB28A@localhost.localdomain>
	<20060307005002.GA15640@MAIL.13thfloor.at>
	<1141696822.9274.54.camel@localhost.localdomain>
	<20060307024505.GA15713@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 19 Mar 2006 08:54:02 -0700
In-Reply-To: <20060307024505.GA15713@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Tue, 7 Mar 2006 03:45:05 +0100")
Message-ID: <m1mzfmwhut.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:
> sure, basically we have two cases which interact
> with userspace: the read and the write case.
>
> for the read case, we want something which gives
> us the 'virtualized' view, which might often be
> the same as the host gets, where for the write
> case it is usually not that simple, as we might
> not want a context to write to 'world' stuff
>
> so, having two different functions here, or one
> which gets passed the direction, might be much
> simpler to adjust in many cases than adding more
> and more structures ... but YMMV

I'm not convinced either way yet but my gut feel is that
the use case for get/put functions is incomplete permission
checks on various sysctls.

If that is the fixing the permission checks looks like the
right thing to do.

Eric
