Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280592AbRLDEag>; Mon, 3 Dec 2001 23:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280434AbRLDEa0>; Mon, 3 Dec 2001 23:30:26 -0500
Received: from zero.tech9.net ([209.61.188.187]:22276 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280674AbRLDEaQ>;
	Mon, 3 Dec 2001 23:30:16 -0500
Subject: Re: [PATCH] improve spinlock debugging
From: Robert Love <rml@tech9.net>
To: "David S. Miller" <davem@redhat.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011203.202130.118628301.davem@redhat.com>
In-Reply-To: <3C0BDC33.6E18C815@colorfullife.com> 
	<20011203.202130.118628301.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 03 Dec 2001 23:30:15 -0500
Message-Id: <1007440220.1303.14.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-03 at 23:21, David S. Miller wrote:

> Keep track of how many locks are being held at once, and check if it
> is zero at switch_to() time.  You can also do this to measure things
> like max number of locks held at once and other statistics.
> 
> I added the first bit to sparc64 while hunting down a bug.

Another interesting idea is see if a lock is held during a call to
udelay.

Once you get a lock count, a lot is possible.  I have looked into doing
some of these tests with the preemptible kernel patch.  Since the
preemption count is essential the lock depth, we have quick access to
all this data.

	Robert Love

