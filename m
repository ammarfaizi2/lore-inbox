Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVIHNTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVIHNTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVIHNTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:19:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22899 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751348AbVIHNTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:19:20 -0400
Date: Thu, 8 Sep 2005 15:19:29 +0200
From: Jens Axboe <axboe@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Reuse of BIOs
Message-ID: <20050908131922.GA6097@suse.de>
References: <11859.1126185451@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11859.1126185451@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08 2005, David Howells wrote:
> 
> Hi Jens,
> 
> Is it possible to reuse a BIO once the callback on it has been invoked to
> indicate final completion? Or does it have to be released and another one
> allocated?

If you reuse it indefinitely, you violate the principles that make the
mempool work. So the answer is 'yes' if you only reuse it a little, 'no'
if you want to hang on to it forever.

-- 
Jens Axboe

