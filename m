Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSKNRiK>; Thu, 14 Nov 2002 12:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbSKNRgn>; Thu, 14 Nov 2002 12:36:43 -0500
Received: from mons.uio.no ([129.240.130.14]:32431 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S265095AbSKNRgC>;
	Thu, 14 Nov 2002 12:36:02 -0500
To: root@chaos.analogic.com
Cc: Chuck Lever <cel@citi.umich.edu>, Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new timeout behavior for RPC requests on TCP sockets
References: <Pine.LNX.3.95.1021113133354.2518B-100000@chaos.analogic.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 14 Nov 2002 16:41:22 +0100
In-Reply-To: <Pine.LNX.3.95.1021113133354.2518B-100000@chaos.analogic.com>
Message-ID: <shsd6p8qhul.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Richard B Johnson <root@chaos.analogic.com> writes:

     > The Client is the guy that just retries, as you say from a
     > time-out.  This shouldn't affect any internal TCP/IP code. The
     > time-out is at the application (client) level. It sent a
     > request, the data was sent or promised to be sent because the
     > write() or send() didn't block, now it expects to get the data
     > it asked for. It waits, nothing happens. It times-out and sends
     > the exact same request again.

Huh??? There's no 'application level' involved here at all, nor any
'internal TCP/IP code'.

Chuck's patch touches the way the kernel Sun RPC client code (as used
exclusively by the kernel NFS client and the kernel NLM client)
handles the generic case of message timeout + resend. Why would we
want to even consider pushing that sort of thing down into the NFS
code itself?

Cheers,
  Trond
