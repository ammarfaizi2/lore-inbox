Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753527AbWKQIGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbWKQIGM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 03:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753377AbWKQIGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 03:06:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59067 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753527AbWKQIGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 03:06:12 -0500
Date: Fri, 17 Nov 2006 08:06:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Avi Kivity <avi@qumranet.com>
Cc: Arnd Bergmann <arnd@arndb.de>, kvm-devel@lists.sourceforge.net,
       akpm@osdl.org, linux-kernel@vger.kernel.org, uril@qumranet.com
Subject: Re: [kvm-devel] [PATCH 3/3] KVM: Expose MSRs to userspace
Message-ID: <20061117080602.GA32211@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Avi Kivity <avi@qumranet.com>, Arnd Bergmann <arnd@arndb.de>,
	kvm-devel@lists.sourceforge.net, akpm@osdl.org,
	linux-kernel@vger.kernel.org, uril@qumranet.com
References: <455CA70C.9060307@qumranet.com> <20061116180422.0CC9325015E@cleopatra.q> <200611162008.48931.arnd@arndb.de> <455CB93E.4090309@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455CB93E.4090309@qumranet.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 09:17:18PM +0200, Avi Kivity wrote:
> Heh.  That was the original implementation by Uri.  I felt that was 
> wrong because _IOW() encodes the size in the ioctl number, bit the 
> actual size is different.

That really shouldn't be a problem.  After all the pointer approach
doesn't encode the transfered size either. Given that the variable
sized array gives a much cleaner interface you should use it.

