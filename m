Return-Path: <linux-kernel-owner+w=401wt.eu-S964923AbXAJP6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbXAJP6x (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 10:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbXAJP6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 10:58:53 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47288 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964923AbXAJP6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 10:58:52 -0500
Date: Wed, 10 Jan 2007 09:58:45 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Mimi Zohar <zohar@us.ibm.com>,
       akpm@osdl.org, kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@saff.watson.ibm.com
Subject: Re: mprotect abuse in slim
Message-ID: <20070110155845.GA373@sergelap.austin.ibm.com>
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com> <1168312045.3180.140.camel@laptopd505.fenrus.org> <20070109094625.GA11918@infradead.org> <20070109231449.GA4547@sergelap.austin.ibm.com> <Pine.LNX.4.64.0701100914550.22496@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701100914550.22496@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pekka J Enberg (penberg@cs.helsinki.fi):
> On Tue, 9 Jan 2007, Serge E. Hallyn wrote:
> > Whatever happened with Pekka's revoke submissions?  Did you lose
> > interest after
> > http://www.kernel.org/pub/linux/kernel/people/penberg/patches/revoke/2.6.19-rc1/revoke-2.6.19-rc1,
> > or was it decided that the approach was unworkable?
> 
> Lack of time.

Ok great - then it's not dead  :)

> Also, I would love to hear comments on the way I am doing
> revoke on shared mappings. There are few open issues remaining, mainly,
> supporting munmap(2) for revoked mappings.

Hmm, I wanted to test your revoke-munmap.c to see what you get right now
with munmap, but a quick port of your patch to yesterdays -git on s390
gives me an oops on do_revoke.  I'll have to straighten that out when I
get a chance.

But since it looks like you just munmap the region now, shouldn't a
subsequent munmap by the app just return -EINVAL?  that seems appropriate
to me.

thanks,
-serge
