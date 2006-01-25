Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWAYJ1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWAYJ1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWAYJ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:27:24 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:8374 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751077AbWAYJ1Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:27:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e77TeL5dORldYUy7tES6qyJ5KoYnEbqUx4DDY+BgQ7IojpN6JxkZ7/Z2YVkpwIEOdcFt92xnUeaMDFGwAakJjjJYKltF/qP60LuyIWVQsGf8I0xgFLToDcAGqogdLLR+M/y5RMbFyl4TAUlfegY2n56NVKv7VdCYJED4E0cNCms=
Message-ID: <1e62d1370601250127r50eaf50dg5ad705877dbf771c@mail.gmail.com>
Date: Wed, 25 Jan 2006 14:27:22 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Subject: Re: Block device API
Cc: Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060125083728.GA16593@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a0601241858g260b915bs5370d34ac90321de@mail.gmail.com>
	 <1e62d1370601241917l4c53cf3fud34835c4dc5c1526@mail.gmail.com>
	 <20060125083728.GA16593@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/06, Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
> On Wed, Jan 25, 2006 at 08:17:02AM +0500, Fawad Lateef wrote:
> >
> > AFAIK there isn't any documentation/article for block and filesystem
> > layer interaction (or till now me also not able to find any) :)
> >
> >
> > sb_bread is the function used for reading a block (especially
> > superblock) from the storage. For reading/writing do look at
>
> Does __bread() contribute to page cache? I think not. And we don't
> care the work done by __bread().
>

Ya, __bread() directly sends read request to the block device without
involvement of buffer cache ! Is there any point In my explaination in
which I mentioned __bread related to buffer_cache ? if yes then its a
mistake .... and __bread is direct function which calls submit_bh and
waits for its completion.

--
Fawad Lateef
