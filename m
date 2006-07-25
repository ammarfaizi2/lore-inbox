Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWGYJ1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWGYJ1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWGYJ1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:27:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20122 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751526AbWGYJ1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:27:05 -0400
Date: Tue, 25 Jul 2006 10:26:56 +0100
From: hch <hch@infradead.org>
To: Ed Lin <ed.lin@promise.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       "James.Bottomley" <James.Bottomley@SteelEye.com>,
       hch <hch@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, promise_linux <promise_linux@promise.com>,
       jeff <jeff@garzik.org>
Subject: Re: [PATCH] Promise 'stex' driver
Message-ID: <20060725092656.GA28195@infradead.org>
Mail-Followup-To: hch <hch@infradead.org>, Ed Lin <ed.lin@promise.com>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	"James.Bottomley" <James.Bottomley@SteelEye.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
	promise_linux <promise_linux@promise.com>, jeff <jeff@garzik.org>
References: <NONAMEBFJ3sl3xbYiMC000000d4@nonameb.ptu.promise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NONAMEBFJ3sl3xbYiMC000000d4@nonameb.ptu.promise.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 12:41:11PM +0800, Ed Lin wrote:
> 
> So it seems there are several possibilities here(regarding no.1 comment):
> 1.The bridge code is kept unchanged. And, as this is a violation to
> Linux tradition and requirement, it could not be admitted upstream.

We have more than enough precedence for poking the bridge that comes as
part of addon cards.  As long as the code makes sure it never pokes a bridge
of the same type that is not on the card (and I don't have the code in front
of me right now to check whether it's true) we can keep this code.  Please
make sure to add a big comment that explains what is going on in detail
and why it's okay in this special case.

