Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280779AbRKYJUy>; Sun, 25 Nov 2001 04:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280781AbRKYJUo>; Sun, 25 Nov 2001 04:20:44 -0500
Received: from weta.f00f.org ([203.167.249.89]:4249 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S280779AbRKYJUi>;
	Sun, 25 Nov 2001 04:20:38 -0500
Date: Sun, 25 Nov 2001 22:22:14 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Steve Bergman <steve@rueb.com>, linux-kernel@vger.kernel.org
Subject: Re: Disk hardware caching, performance, and journalling
Message-ID: <20011125222214.C9672@weta.f00f.org>
In-Reply-To: <3BFFE8A2.1010708@rueb.com> <3BFFF021.D963B467@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BFFF021.D963B467@zip.com.au>
User-Agent: Mutt/1.3.23i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 11:08:17AM -0800, Andrew Morton wrote:

    In theory, yes.  In my opinion, no.  For ext3, at least.  Caching
    isn't bad per-se.  It's reordering which can break the journalling
    constraints.

Some disks[1] most definately do reorder;  I've actually been able to
demonstrate this in some circumstances (it wasn't trivial to
produce and required several attempts).



  --cw

[1] SCSI, which we know does and will reorder writes when a barrier
    isn't specificed, it appears IDE drives can do the same but lack of
    hot-swap makes testing tedious :)
