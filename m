Return-Path: <linux-kernel-owner+w=401wt.eu-S1750773AbXAKPuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbXAKPuF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 10:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbXAKPuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 10:50:05 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:50469 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbXAKPuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 10:50:01 -0500
Date: Thu, 11 Jan 2007 09:49:57 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Mimi Zohar <zohar@us.ibm.com>,
       akpm@osdl.org, kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@saff.watson.ibm.com
Subject: Re: mprotect abuse in slim
Message-ID: <20070111154957.GG4791@sergelap.austin.ibm.com>
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com> <1168312045.3180.140.camel@laptopd505.fenrus.org> <20070109094625.GA11918@infradead.org> <20070109231449.GA4547@sergelap.austin.ibm.com> <Pine.LNX.4.64.0701100914550.22496@sbz-30.cs.Helsinki.FI> <20070110155845.GA373@sergelap.austin.ibm.com> <84144f020701102339n1935b0a7v5ca3419fe3b66be5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020701102339n1935b0a7v5ca3419fe3b66be5@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pekka Enberg (penberg@cs.helsinki.fi):
> On 1/10/07, Serge E. Hallyn <serue@us.ibm.com> wrote:
> >But since it looks like you just munmap the region now, shouldn't a
> >subsequent munmap by the app just return -EINVAL?  that seems appropriate
> >to me.
> 
> Applications don't know about revoke and neither should they.
> Therefore close(2) and munmap(2) must work the same way they would for
> non-revoked inodes so that applications can release resources
> properly.
> 
>                                         Pekka

Right, but is returning -EINVAL to userspace on munmap a problem?
It may not have been expected before, but it shouldn't break
anything...

Thanks for the tw other patches - I'll give them a shot and check
out current munmap behavior just as soon as I get a chance.

thanks,
-serge

