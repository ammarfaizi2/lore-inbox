Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262145AbTCRCx4>; Mon, 17 Mar 2003 21:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262148AbTCRCx4>; Mon, 17 Mar 2003 21:53:56 -0500
Received: from pat.uio.no ([129.240.130.16]:17638 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262145AbTCRCxz>;
	Mon, 17 Mar 2003 21:53:55 -0500
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs and getattr
References: <20030318014700.GA28769@werewolf.able.es>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Mar 2003 04:04:46 +0100
In-Reply-To: <20030318014700.GA28769@werewolf.able.es>
Message-ID: <shsy93dtlwx.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == J A Magallon <J.A.> writes:

     > What is that ton of getattr ? Do they come from nfs itself or
     > must be done by the reader via stat()s (perhaps it checks for
     > file presence before opening) ?

See the fine Linux Kernel archives.

They come mainly from open(). Use the "nocto" option if you think you
can do without them, but *do not* do so if you think there might be
any chance whatsoever of 1 machine having to access a file that
another machine has written.

Cheers,
  Trond
