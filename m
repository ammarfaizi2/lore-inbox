Return-Path: <linux-kernel-owner+w=401wt.eu-S932423AbXAIU4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbXAIU4f (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 15:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbXAIU4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 15:56:35 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:49091 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932423AbXAIU4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 15:56:34 -0500
Date: Tue, 9 Jan 2007 12:54:47 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Mimi Zohar <zohar@us.ibm.com>,
       akpm@osdl.org, kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com
Subject: Re: mprotect abuse in slim
Message-ID: <20070109205447.GF6602@sequoia.sous-sol.org>
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com> <1168312045.3180.140.camel@laptopd505.fenrus.org> <20070109094625.GA11918@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109094625.GA11918@infradead.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig (hch@infradead.org) wrote:
> On Mon, Jan 08, 2007 at 07:07:25PM -0800, Arjan van de Ven wrote:
> > maybe this is a silly question, but do you revoke not only the current
> > fd entries, but also the ones that are pending in UNIX domain sockets
> > and that are already being sent to the process? If not.. then you might
> > as well not bother ;)
> 
> Exactly.  What these folks want is revoke (maybe more fine grained, but
> that's not the point).  And guess what folks, revoke is not trivial,
> otherwise we'd have it.  If you want to volunteer to implement a full-blown
> revoke that's fine, but
> 
>   a) it belongs into core code
>   b) needs to be done right

Very much agreed.  There's way too many holes in half-way done revocation.

thanks,
-chris
