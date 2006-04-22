Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWDVRIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWDVRIU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 13:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWDVRIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 13:08:20 -0400
Received: from uproxy.gmail.com ([66.249.92.170]:22308 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750703AbWDVRIT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 13:08:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JrP4oiYkoclfynrB+mImWjX6EtpKY3+iqr76lvbLWlq3Ou1dqjmhTXuQR31EWJdoRYR9zvGLVbkc82KtCu1uGU7SMPzQF8y3bZ+nxB49B1ZztZMyzFj/W9p8SGou1itwHLboh4j6gPr2rTJLjr8S12YWbMHZ0AFcLlIwGXr0Kqk=
Message-ID: <82ecf08e0604221008ieb22a4cuc59be570cf025bba@mail.gmail.com>
Date: Sat, 22 Apr 2006 14:08:18 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Jim Ramsay" <kernel@jimramsay.com>
Subject: Possible MTD bug in 2.6.15
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <4789af9e0604220949i2757e408qa5de3a9e728e966f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145723704.3524.TMDA@mail.tag.jimramsay.com>
	 <4789af9e0604220949i2757e408qa5de3a9e728e966f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Ok, a couple of comments/questions
> > >
> > > 1 - Wouldn't it be better to map all flash, and leave the unneeded
> > > part as read only?
>
> In general, yes.  But this should either be enforced somewhere nicer
> (ie, die gracefully) so the kernel doesn't panic later, or be allowed
> as in my patch.

The fundamental problem there seems to be a mismatch between what is
set by the user and what is read from the flash chip. As you mention
in your first message, (what it came across is that) you don't have
(physical / electrical) access to all the flash; not something I would
recommend (that is, having limited electrical connection to the flash)

As for the options you propose - enforce and die gracefully (that is,
if there is a size mismatch, warning and purposely not working) seems
more correct than the second option.
