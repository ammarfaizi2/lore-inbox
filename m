Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTJFOoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTJFOoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:44:54 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:28177 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262259AbTJFOox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:44:53 -0400
Date: Mon, 6 Oct 2003 15:44:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] s390 (2/7): common i/o layer.
Message-ID: <20031006154451.A20620@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <OF0C1219E4.69DD3439-ONC1256DB7.004E702C-C1256DB7.00509377@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF0C1219E4.69DD3439-ONC1256DB7.004E702C-C1256DB7.00509377@de.ibm.com>; from schwidefsky@de.ibm.com on Mon, Oct 06, 2003 at 04:40:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 04:40:06PM +0200, Martin Schwidefsky wrote:
> 
> Hi Christoph,
> 
> > Eek.  How is the dummy release function supposed to help
> > anything?  you must free the object in ->release.  Also
> > the assignment is horrible as hell.
> 
> Just checked. You right about chp_release which should do
> a kfree on the struct channel_path object. But the two
> other release functions are really dummy functions because
> cu3088_root_dev and iucv_root are static structures.

Even in that case you're screwed in case they are in modules..

