Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261762AbTCLQmM>; Wed, 12 Mar 2003 11:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261764AbTCLQmM>; Wed, 12 Mar 2003 11:42:12 -0500
Received: from air-2.osdl.org ([65.172.181.6]:33242 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261762AbTCLQmJ>;
	Wed, 12 Mar 2003 11:42:09 -0500
Date: Wed, 12 Mar 2003 08:50:32 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Message-Id: <20030312085032.7d536566.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.30.0303120622290.15538-100000@divine.city.tvnet.hu>
References: <b4lvk2$vcd$1@cesium.transmeta.com>
	<Pine.LNX.4.30.0303120622290.15538-100000@divine.city.tvnet.hu>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003 07:07:26 +0100 (MET) Szakacsits Szabolcs <szaka@sienet.hu> wrote:

| 
| On 11 Mar 2003, Linus Torvalds wrote:
| >
| > If there is a well-known list of compilers, we should put a BIG warning
| > in some core kernel file to guide people to upgrade (or maybe work
| 
| Not enough, nobody would notice and today most end user doesn't
| compile the kernel himself, they are just shipped by a broken kernels.
| 
| We *also* need a mechanism to know the kernel was compiled with a
| broken compiler (from kernel point of view of course, not the latest
| C++ features). Like the 'tainted' approach but this would be marked as
| broken/miscompiled/etc. To be able to tell the user *immediately* to
| complain to his vendor instead hunting/finding the bug again and
| again, as happening now.

Not quite what you describe, but the in-kernel-config (ikconfig) patch by
me & some HP folks saves a "built-with" string along with the .config file
(as a CONFIG option, of course).


| BTW, if possible having the Code both before and after when a fault
| happens could also help a lot in the future.

Do you just mean more opcode decoding?

| And in general, an oops counter would be also useful, not spending too
| much time decoding potentialy bogus oopses.

Yes.

--
~Randy
