Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265946AbUHGDGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265946AbUHGDGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 23:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUHGDGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 23:06:17 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:36289 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S265946AbUHGDGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 23:06:07 -0400
Date: Fri, 6 Aug 2004 23:01:19 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Matt Mackall <mpm@selenic.com>
Cc: James Morris <jmorris@redhat.com>,
       "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       mludvig@suse.cz, cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: [PATCH]
Message-ID: <20040807030118.GN23994@certainkey.com>
References: <20040806042852.GD23994@certainkey.com> <Xine.LNX.4.44.0408060040360.20834-100000@dhcp83-76.boston.redhat.com> <20040806125427.GE23994@certainkey.com> <20040806232452.GA5414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806232452.GA5414@waste.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 06:24:52PM -0500, Matt Mackall wrote:
> On Fri, Aug 06, 2004 at 08:54:27AM -0400, Jean-Luc Cooke wrote:
> > On Fri, Aug 06, 2004 at 12:42:38AM -0400, James Morris wrote:
> > > On Fri, 6 Aug 2004, Jean-Luc Cooke wrote:
> > > 
> > > > James,
> > > >   Back to your question:
> > > >     I want to replace the legacy MD5 and the incorrectly implemented SHA-1
> > > >     implementations from driver/char/random.c
> > > 
> > > Incorrectly implemented?  Do you mean not appending the bit count?
> > 
> > That and it's not endian-correct.
> 
> Are you saying that it's hashing incorrectly or that the final form is
> not in the standard bit-order? For the purposes of a random number
> generator, the latter isn't terribly important. Nor is it particularly
> important for GUIDs.

The problems with the SHA1 implementation is the least of random.c's
concerns.  But it's just bad taste to tell on-lookers "we use SHA-1" and you
actually don't.  It causes people to re-evailuate your implementation.

Ease of reading, ease of analysis are related to using proper implementations
of cryptographic primitives.

> Last time I proposed a cryptoapi-based version, I couldn't get any
> buy-off on making cryptoapi a non-optional part of the kernel. Looking
> forward to your patch/paper.

I'll credit you for breaking the ice if capi becomes a standard feature.  ;)

JLC
