Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTIVQC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbTIVQC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:02:58 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:22712 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263212AbTIVQCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:02:55 -0400
Date: Mon, 22 Sep 2003 17:02:22 +0100
From: Dave Jones <davej@redhat.com>
To: CaT <cat@zip.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Kronos <kronos@kronoz.cjb.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix Athlon MCA
Message-ID: <20030922160222.GF15344@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, CaT <cat@zip.com.au>,
	Linus Torvalds <torvalds@osdl.org>, Kronos <kronos@kronoz.cjb.net>,
	linux-kernel@vger.kernel.org
References: <20030921143934.GA1867@dreamland.darkstar.lan> <Pine.LNX.4.44.0309211034080.11614-100000@home.osdl.org> <20030921174731.GA891@redhat.com> <20030922142023.GC514@zip.com.au> <20030922144345.GC15344@redhat.com> <20030922150601.GD514@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922150601.GD514@zip.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 01:06:01AM +1000, CaT wrote:
 > On Mon, Sep 22, 2003 at 03:43:45PM +0100, Dave Jones wrote:
 > > The bank is referring to an MCE bank rather than a memory slot.
 > > Each MCE bank checks different things.
 > 
 > ahhh. ok. Well... I found your parsemce.c source. got it compiled it. Ran:
 > 
 > ./parsemce -b 2 -e 940040000000017a
 > 
 > and got:
 > 
 > Status: (940040000000017a) Error IP valid
 > Restart IP invalid.
 > 
 > What the snot does that mean? 8)

If this was from a kernel that didn't clear that bank on boot,
it's bogus, and you can ignore it.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
