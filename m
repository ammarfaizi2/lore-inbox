Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267223AbUG2JFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267223AbUG2JFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 05:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267321AbUG2JFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 05:05:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:28847 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267223AbUG2JFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 05:05:10 -0400
Date: Thu, 29 Jul 2004 02:02:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: peter@chubb.wattle.id.au, viro@parcelfarce.linux.theplanet.co.uk,
       davem@redhat.com, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
Message-Id: <20040729020252.0eaed212.akpm@osdl.org>
In-Reply-To: <20040729014940.7f1e3315.pj@sgi.com>
References: <233602095@toto.iv>
	<16648.10711.200049.616183@wombat.chubb.wattle.id.au>
	<20040728154523.20713ef1.davem@redhat.com>
	<20040729000837.GA24956@taniwha.stupidest.org>
	<20040728171414.5de8da96.davem@redhat.com>
	<20040729002924.GK12308@parcelfarce.linux.theplanet.co.uk>
	<16648.42669.907048.112765@wombat.chubb.wattle.id.au>
	<20040729004242.7601f777.akpm@osdl.org>
	<20040729014940.7f1e3315.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Andrew wrote:
>  > hmm.  Here's a Pentium III profile ...
> 
>  What conclusion do your draw from this profile?

At a quick squint: we spend about 10% of total system time in those copy
functions.  If we halve their runtime (which would be good), we don't gain
much.

