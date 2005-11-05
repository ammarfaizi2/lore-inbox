Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVKESsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVKESsU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVKESsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:48:20 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:39098 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932197AbVKESsT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:48:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uUzif5QrI2Z+jzzojrJ+Gb55XHNApojll6t9B6/84bXWZS89Vz4E6At4VXehG6CQdt9p0Znb3tPFlweNUMIlcfn4dgJAAtICfUbSu2YmcCk04gR27WnWji0Mny6gQgk9tUU6A2/VHC2Odot3StKI3lN1vbJh9BWt72cx8Zq2kiI=
Message-ID: <35fb2e590511051048iada9db4pa09bbf305f56c57d@mail.gmail.com>
Date: Sat, 5 Nov 2005 18:48:18 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: PATCH: fix-readonly-policy-use-and-floppy-ro-rw-status
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051105184222.GN7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051105182728.GB27767@apogee.jonmasters.org>
	 <20051105103358.2e61687f.akpm@osdl.org>
	 <20051105184222.GN7992@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/05, Al Viro <viro@ftp.linux.org.uk> wrote:

> On Sat, Nov 05, 2005 at 10:33:58AM -0800, Andrew Morton wrote:
> > Jon Masters <jonathan@jonmasters.org> wrote:
> > >
> > > [PATCH]: This modifies the gendisk and hd_struct structs to replace "policy"
> > >  with "readonly" (as that's the only use for this field).

> ... for now.  IOW, NAK on that part - it's *not* a boolean and it's
> intended to be used for e.g control of caching behaviour.  Stuff
> like "mark it r/o for now without losing information about hw situation"
> also should go there.

But it's not being used for that. The only *uses* I've seen of it
suggest that people are assuming it is a readonly marker.

If you *want* it to be used for such purposes, would you rather I sent
another patch that actually introduced read/write flags to make this
more obvious (if we must keep the existing field around)?

Jon.
