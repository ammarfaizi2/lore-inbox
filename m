Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVISJ3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVISJ3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVISJ3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:29:47 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:49317 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932402AbVISJ3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:29:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=hGZDwv8fWA+4eUctU3vc/LjM4spfSh2FSASnYLNdTHRVwIpC06/briedjIxNM547XaZxk1hr2omYdPz2AFUJMJp+/53tEk4CfqKZjebtJlhiVOHLHX1coLg6YpTf0IMIB16rSgrIeKin6Sd3zO/JM+kwQmWegyKvHtfTxpFA+VA=
Date: Mon, 19 Sep 2005 13:40:07 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050919094007.GA28123@mipter.zuzino.mipt.ru>
References: <432AFB44.9060707@namesys.com> <20050918110658.GA22744@infradead.org> <432E8282.6060905@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432E8282.6060905@namesys.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 01:18:58PM +0400, Vladimir V. Saveliev wrote:
> Christoph Hellwig wrote:
> > I threw in your new codedrop into a compilation and the byte-order
> > mess is _still_ now sorted out.  
> 
> Did compiling notice this mess?
> We used to compile with C=1. Should we compile somehow else before sending code out?

Yes.

	make C=1 CF=-Wbitwise fs/reiser4/
or
	make C=1 CHECK="sparse -Wbitwise" fs/reiser4/

All coming from dformat.h

