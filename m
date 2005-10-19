Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVJSPnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVJSPnk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVJSPnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:43:40 -0400
Received: from qproxy.gmail.com ([72.14.204.207]:29065 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751127AbVJSPnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:43:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=QagfTaQwkP5LfsUoZmCwZFvlwPe+f2bkuA9bGySsuK4IQq6PhBsXJg4mZclnox9QQ4NuUhK3PM8x4pIcY8llYvmMKswxuBjxE58Mi58Hm5zZ4+1RdV6qG5LM/yBa5lfcU8qxxYCvfy3JB2e1DJYH+9t5ScbosP8dLDZite24Wto=
Subject: Re: large files unnecessary trashing filesystem cache?
From: Badari Pulavarty <pbadari@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Guido Fiala <gfiala@s.netic.de>, lkml <linux-kernel@vger.kernel.org>,
       andrew@osdl.org
In-Reply-To: <1129695001.8910.57.camel@mindpipe>
References: <200510182201.11241.gfiala@s.netic.de>
	 <1129695001.8910.57.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 08:43:01 -0700
Message-Id: <1129736581.23632.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 00:10 -0400, Lee Revell wrote:
> On Tue, 2005-10-18 at 22:01 +0200, Guido Fiala wrote:
> > Of course one could always implement f_advise-calls in all
> > applications
> 
> Um, this seems like the obvious answer.  The application doing the read
> KNOWS it's a streaming read, while the best the kernel can do is guess.
> 
> You don't really make much of a case that fadvise can't do the job.

The issue is, how will "other/random" programs/applications affect 
performance of my application.

Complain I hear most is from our database folks, they tune stuff
and they are happy with their performance. And then, some one does 
a tar/cp/cpio/ftp/backup/compile on some random files on the system.
Suddenly, database performance drops. They want to see a system wide/
per-filesystem tunable on how much pagecache it takes up.

Andrew, does this make sense at all ?


Thanks,
Badari

