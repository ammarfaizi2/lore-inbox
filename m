Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWCCVSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWCCVSg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWCCVSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:18:36 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:36053 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750737AbWCCVSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:18:35 -0500
From: Hollis Blanchard <hollisb@us.ibm.com>
Organization: IBM Linux Technology Center
To: linuxppc64-dev@ozlabs.org
Subject: Re: Memory barriers and spin_unlock safety
Date: Fri, 3 Mar 2006 15:18:13 -0600
User-Agent: KMail/1.8.3
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-arch@vger.kernel.org, bcrl@linux.intel.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, mingo@redhat.com, jblunck@suse.de
References: <32518.1141401780@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org> <1141419966.3888.67.camel@localhost.localdomain>
In-Reply-To: <1141419966.3888.67.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603031518.15806.hollisb@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 March 2006 15:06, Benjamin Herrenschmidt wrote:
> The main problem I've had in the past with the ppc barriers is more a
> subtle thing in the spec that unfortunately was taken to the word by
> implementors, and is that the simple write barrier (eieio) will only
> order within the same storage space, that is will not order between
> cacheable and non-cacheable storage.

I've heard Sparc has the same issue... in which case it may not be a "chip 
designer was too literal" thing, but rather it really simplifies chip 
implementation to do it that way.

-- 
Hollis Blanchard
IBM Linux Technology Center
