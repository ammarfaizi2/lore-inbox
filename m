Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272275AbTHDWBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272276AbTHDWBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:01:32 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:43782 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272275AbTHDWBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:01:31 -0400
Date: Mon, 4 Aug 2003 23:01:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chip Salzenberg <chip@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] 2.4.22pre10+aa: XFS has it right, setxattr() takes "const void *"
Message-ID: <20030804230129.A6566@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chip Salzenberg <chip@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrea Arcangeli <andrea@suse.de>
References: <20030804170216.GA5804@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030804170216.GA5804@perlsupport.com>; from chip@pobox.com on Mon, Aug 04, 2003 at 01:02:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 01:02:16PM -0400, Chip Salzenberg wrote:
> It seems that the XFS developers have the right idea about setxattr(),
> namely that it should take a "const void *" parameter for the attributes
> it will set, rather than "void *".
> 
> This patch Makes It So.  It is in some sense only cosmetic, since the
> generated code is the same, but the usage of const is a Good Thing for
> this kind of interface.

Well, the const is how it works on 2.5, 2.4 should not change module
APIs.  Please submit a patch for XFS instead to remove the const for
2.4.

