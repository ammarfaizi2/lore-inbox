Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVKESvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVKESvk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVKESvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:51:40 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:37814 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932193AbVKESvj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:51:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wi/6Ud1QdMLhIb8GAyQcgKd7U8yq1C/k1xZBhcFjI4daq0ejvYmhpDPt75pCGJGTIsJlhspZejjwxI4cGHiTB8hiuEhyrJym2YD9HFhfuoNLyR54jXlzu3ds6ySRJvmLRhjdPiUcDAbLlMWIdTFVSiG3w5fa6L3l8rcvxRxUMK0=
Message-ID: <35fb2e590511051051o16e3e763x821f12555261c4cc@mail.gmail.com>
Date: Sat, 5 Nov 2005 18:51:39 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: PATCH: fix-readonly-policy-use-and-floppy-ro-rw-status
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051105184408.GO7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051105182728.GB27767@apogee.jonmasters.org>
	 <20051105103358.2e61687f.akpm@osdl.org>
	 <20051105184028.GD27767@apogee.jonmasters.org>
	 <20051105184408.GO7992@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/05, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Sat, Nov 05, 2005 at 06:40:28PM +0000, Jon Masters wrote:
> > And as I said, the situation as it stands leads to potential data
> > corruption but I agree with you - we need a VFS callback to handle
> > readwrite/readonly change on remount I think. Comments?

> It's not that simple.  Filesystem side of ro/rw transitions is
> messy as hell

Agreed.

> "VFS callback" won't be enough.

Although strangely enough other similar stuff in the remount path
works just fine. I can already request that a filesystem gets
remounted read-only - what's so wrong with forcing that behaviour when
I ask for an impossible combination?

Jon.
