Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUIAUmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUIAUmv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUIAUmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:42:39 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:700 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267551AbUIAUmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:42:03 -0400
Date: Wed, 1 Sep 2004 21:41:32 +0100
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix leaks in ISOFS.
Message-ID: <20040901204132.GL11182@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <200409011551.i81FpMUY000655@delerium.codemonkey.org.uk> <20040901180050.A13768@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901180050.A13768@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 06:00:50PM +0100, Christoph Hellwig wrote:
 > >    MAYBE_CONTINUE(repeat,inode);
 > > +  if (buffer) kfree(buffer);
 > 
 > kfree(NULL) is just fine

True. I got carried away mirroring the style of all the other
kfree operations in that code.

		Dave

