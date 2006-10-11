Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161229AbWJKU2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161229AbWJKU2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161236AbWJKU2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:28:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161229AbWJKU2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:28:34 -0400
Date: Wed, 11 Oct 2006 16:28:14 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use %p for pointers
Message-ID: <20061011202814.GD20982@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk> <Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr> <20061011145441.GB29920@ftp.linux.org.uk> <452D3BB6.8040200@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452D3BB6.8040200@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 11:45:10AM -0700, H. Peter Anvin wrote:
> Al Viro wrote:
> >
> >%p will do no such thing in the kernel.  As for the difference...  %x
> >might happen to work on some architectures (where sizeof(void 
> >*)==sizeof(int)),
> >but it's not portable _and_ not right.  %p is proper C for that...
> 
> It's really too bad gcc bitches about %#p, because that's arguably The 
> Right Thing.

It is correct that gcc warns about %#p, that invokes undefined behavior
in ISO C99.

	Jakub
