Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbTIVQVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbTIVQVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:21:33 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:57541 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263211AbTIVQVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:21:32 -0400
Date: Mon, 22 Sep 2003 17:20:57 +0100
From: Dave Jones <davej@redhat.com>
To: CaT <cat@zip.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Kronos <kronos@kronoz.cjb.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix Athlon MCA
Message-ID: <20030922162057.GH15344@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, CaT <cat@zip.com.au>,
	Linus Torvalds <torvalds@osdl.org>, Kronos <kronos@kronoz.cjb.net>,
	linux-kernel@vger.kernel.org
References: <20030921143934.GA1867@dreamland.darkstar.lan> <Pine.LNX.4.44.0309211034080.11614-100000@home.osdl.org> <20030921174731.GA891@redhat.com> <20030922142023.GC514@zip.com.au> <20030922144345.GC15344@redhat.com> <20030922150601.GD514@zip.com.au> <20030922160222.GF15344@redhat.com> <20030922160701.GE514@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922160701.GE514@zip.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 02:07:01AM +1000, CaT wrote:

 > Ahhh. Phew. Thanks. I've been wondering. I take it this can show up on
 > a long-running system too? (hopefully someone will find this bit of
 > the thread useful because I saw 1 or 2 msgs in the past but I didn't
 > quite understand the answers)

Ones that turn up after a while should be something different.
This bug was crap left in that register that gets reported, and then
zero'd away. As we don't enable checking in that bank, once its zero
it stays zero.  Anything that triggers afterwards should be coming
from a different bank.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
