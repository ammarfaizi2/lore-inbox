Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268196AbUHFSlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268196AbUHFSlT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268207AbUHFSlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 14:41:19 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:43711 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S268196AbUHFSlQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 14:41:16 -0400
Date: Fri, 6 Aug 2004 14:36:56 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "David S. Miller" <davem@redhat.com>
Cc: jmorris@redhat.com, yoshfuji@linux-ipv6.org, cryptoapi@lists.logix.cz,
       mludvig@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]
Message-ID: <20040806183656.GL23994@certainkey.com>
References: <20040806042852.GD23994@certainkey.com> <Xine.LNX.4.44.0408060040360.20834-100000@dhcp83-76.boston.redhat.com> <20040806125427.GE23994@certainkey.com> <20040806112646.7931585e.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806112646.7931585e.davem@redhat.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK then,

I tried.  scretterlists it is... I'm a push over.  ;)

JLC

On Fri, Aug 06, 2004 at 11:26:46AM -0700, David S. Miller wrote:
> On Fri, 6 Aug 2004 08:54:27 -0400
> Jean-Luc Cooke <jlcooke@certainkey.com> wrote:
> 
> > If I can avoid scatter-gather for what is effectively just mixing bytes with
> > SHA256
> > & AES256 then this would make things very neat and tidy (read: easier for
> > peer review)
> 
> Why do you care about scatter gather at all?  You need to allocate
> a kernel buffer to copy the user bits into _anyways_.  Once you
> have a kernel buffer, doing a quick onstack one-entry scatter list
> is simple.
> 
> If you're trying to use the user buffer directly, sorry we're not
> going to add support for that, as Linus explained it's silly.
