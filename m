Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbWIRObQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWIRObQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965269AbWIRObQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:31:16 -0400
Received: from mail.suse.de ([195.135.220.2]:5807 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965248AbWIRObP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:31:15 -0400
From: Andi Kleen <ak@suse.de>
To: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: TCP stack behaviour question
Date: Mon, 18 Sep 2006 16:31:10 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, "Michael Kerrisk" <mtk-manpages@gmx.net>
References: <002801c6db2d$67d8a3a0$294b82ce@stuartm>
In-Reply-To: <002801c6db2d$67d8a3a0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609181631.10625.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 September 2006 16:19, Stuart MacDonald wrote:
> From: Andi Kleen [mailto:ak@suse.de] 
> > > # man 7 ip
> > > ..
> > >                Note that TCP has no error queue; MSG_ERRQUEUE is
> > > illegal on SOCK_STREAM sockets.  Thus all errors are returned by
> > > socket function return or SO_ERROR only.
> > > 
> > > Maybe the man page is wrong? That's from my FC 3 install.
> > 
> > The sentence is correct, but TCP has a IP_RECVERR that works
> > differently without a queue. Basically it doesn't delay the error 
> > reporting for incoming ICMPs to the last retransmit, but reports
> > them immediately. This is documented in tcp(7)
> 
> I read that too, but didn't know which one was correct, so I erred on
> the side of caution and believed ip(7).

Ok maybe it's a bit misleading. Michael, you might want to clarify.

-Andi
