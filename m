Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbWADCzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWADCzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 21:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWADCzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 21:55:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39909 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965174AbWADCzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 21:55:36 -0500
Date: Tue, 3 Jan 2006 18:55:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: ananth@in.ibm.com
Cc: linux-kernel@vger.kernel.org, prasanna@in.ibm.com,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [-mm PATCH] kprobes: fix build break in 2.6.15-rc5-mm3
Message-Id: <20060103185508.53f65bf9.akpm@osdl.org>
In-Reply-To: <20051220095432.GA5139@in.ibm.com>
References: <20051220095432.GA5139@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:
>
> The following patch (against 2.6.15-rc5-mm3) fixes a kprobes build
>  break due to changes introduced in the kprobe locking in
>  2.6.15-rc5-mm3. In addition, the patch reverts back the open-coding
>  of kprobe_mutex.

Complaints:

a) Your changelog failed to describe what the build breakage was.  It helps.

b) the changelog fails to describe _why_ we've reverted the locking

c) The patch does multiple things.

See, what I would _like_ to do is to fold the fixes in this patch into the
patches which are already in -mm.  That way, the patches which hit Linus's
tree will be neater and won't introduce build breakage at any point.

And they won't add stuff and then immediately take it away again.  That's
for git losers ;)

But the patch which you've sent doesn't have a hope of applying anywhere
except at the end of the patches which I already have.

The net result is that we'll hit Linus's tree with a bunch of patches, and
then a followup patch which fixes those patches.  Which is a dumb way in
which to present the permanent kernel record, given that we have an
opportunity to get it right first time, no?

Here's the bottom line: please never ever ever ever ever ever do more than
one thing in a single patch.  Ever.  Did I mention "ever"?  There are soooo
many reasons for this....

