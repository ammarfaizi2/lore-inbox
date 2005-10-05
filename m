Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbVJETcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbVJETcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbVJETcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:32:05 -0400
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:57807 "EHLO
	mail25.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030335AbVJETcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:32:04 -0400
Date: Wed, 5 Oct 2005 15:31:59 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
In-Reply-To: <30441.1128530889@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.63.0510051529280.23676@excalibur.intercode>
References: <Pine.LNX.4.63.0510051241580.23070@excalibur.intercode> 
 <29942.1128529714@warthog.cambridge.redhat.com>  <30441.1128530889@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, David Howells wrote:

> > Any reason why this is configurable?
> 
> Well, I saw that the network stuff was. I can make it non-configurable.
> 
> > Why wouldn't someone want this?
> 
> Speed/latency? But I suppose that's not really a factor.

Yes, the networking is for performance, especially from when we used to 
register Netfilter hooks from within LSM.  I don't know of any distros 
that enable LSM but disable networking so we should probably think about 
removing that as well.

> What about the security ops for keys that I've made available? Does doing it
> that way seem reasonable?

Not sure yet, need to spend some time looking at this from an SELinux 
point of view.


- James
-- 
James Morris
<jmorris@namei.org>
