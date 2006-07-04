Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWGDLsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWGDLsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWGDLsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:48:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31892 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932212AbWGDLso (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:48:44 -0400
Date: Tue, 4 Jul 2006 12:48:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <Linux-Kernel@vger.kernel.org>,
       reiserfs-dev@namesys.com
Subject: Re: [PATCH 1/2] batch-write.patch
Message-ID: <20060704114836.GA1344@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Vladimir V. Saveliev" <vs@namesys.com>,
	Andrew Morton <akpm@osdl.org>, lkml <Linux-Kernel@vger.kernel.org>,
	reiserfs-dev@namesys.com
References: <44A42750.5020807@namesys.com> <20060629185017.8866f95e.akpm@osdl.org> <1152011576.6454.36.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152011576.6454.36.camel@tribesman.namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 03:12:56PM +0400, Vladimir V. Saveliev wrote:
> 
> > Should this be an address_space_operation or a file_operation?
> > 
> 
> I was seeking to be minimal in my changes to the philosophy of the code.
> So, it was an address_space operation. Now it is a file operation.

It definitly should not be a file_operation! It works at the address_space
not the much higher file level.  Maybe all three should become callbacks
for the generic write routines, but that's left for the future.
