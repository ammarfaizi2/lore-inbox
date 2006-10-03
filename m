Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965546AbWJCAg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965546AbWJCAg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 20:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965548AbWJCAg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 20:36:58 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:34121 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965546AbWJCAg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 20:36:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gqFUcpeSeZW3vC7RbiOyUqFOiTpqIMtZUQ8Y4AdfUuIJTr4vD8XVcOyVadIvb5sPvF/dhkQJiqucNy9AP3oG1s+LWfhGDf/ZjISwR233YaOi5rqvTWDUecoseQQWRdyH4tJParWsNneUyxZVpm1YlE0jMQF+qowX/GOu2t+EB3k=
Message-ID: <21d7e9970610021736s2335a04ap42f3b5bf961cb704@mail.gmail.com>
Date: Tue, 3 Oct 2006 10:36:53 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Cc: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       "David Howells" <dhowells@redhat.com>,
       "Thomas Gleixner" <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, "Dmitry Torokhov" <dtor@mail.ru>,
       "Greg KH" <greg@kroah.com>, "David Brownell" <david-b@pacbell.net>,
       "Alan Stern" <stern@rowland.harvard.edu>
In-Reply-To: <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	 <20061002132116.2663d7a3.akpm@osdl.org>
	 <20061002201836.GB31365@elte.hu>
	 <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Things like the kernel graphics direct-rendering code, for example -
> mostly maintained in X.org trees that then want to compile with other
> kernels too.

Well in the DRM case we don't worry about that too much, the external
DRM git tree has all the compat code hidden away and I've got lots of
version check macros, so one more won't make a difference, the in-tree
version has none of the that stuff anyways....

Now it might break nvidia and ATI but that is all code that is in
their "public" source...

Dave.
