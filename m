Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVEKJAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVEKJAC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 05:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVEKI5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:57:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59818 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261942AbVEKI4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:56:24 -0400
Date: Wed, 11 May 2005 09:56:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steve French <smfrench@austin.rr.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
Message-ID: <20050511085619.GA24841@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
References: <4272A275.4030801@austin.rr.com> <20050429213108.GA15262@infradead.org> <4272B335.5090207@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4272B335.5090207@austin.rr.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 05:20:37PM -0500, Steve French wrote:
> I agree that it would work for most cases [today, in 2.6 Linux] - but I 
> really feel uncomfortable introducing a user space / kernel space 
> dependency on the size of a field where none is needed - I am especially 
> nervous because I can see from the Samba change logs that:

Please listen, I said you should export it in /proc/<pid>/mounts, which is
an ASCII interface and any half-sane parser does not depend on the width
of the field in the kernel.

Can we please get rid of the broken ioctl now so it doesn't become part
of the ABI and you'll add the trivial output to /proc/<pid>/mounts?

