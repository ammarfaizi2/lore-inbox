Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSF1F4s>; Fri, 28 Jun 2002 01:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSF1F4i>; Fri, 28 Jun 2002 01:56:38 -0400
Received: from [209.184.141.190] ([209.184.141.190]:63440 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317066AbSF1F4h>;
	Fri, 28 Jun 2002 01:56:37 -0400
Subject: Re: kernel BUG
From: Austin Gonyou <austin@digitalroadkill.net>
To: Chaoyang Deng <cdeng@io.iol.unh.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.43.0206271514230.9712-100000@io.iol.unh.edu>
References: <Pine.LNX.4.43.0206271514230.9712-100000@io.iol.unh.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 28 Jun 2002 00:58:52 -0500
Message-Id: <1025243932.2956.3.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My recommendation for this is to *not* use the in-kernel qla2xxx driver.
Not that it's necessarily bad mind you, but much new hardware doesn't
seem to like it. I've locked up a box several times using it. Instead, I
recommend that you go to qlogic's site and get 6.0.27 and try it. It's
much faster than the previous drivers, and has been very stable and
compile's with no warnings ever, at least in my scenario. 

I recently had an issue with a QL2xxx driver, some storage, and LUNs. My
issue turned out to be a blacklist issue, but, I got a lot of info from
the Qlogic folks as well, regarding which driver should be used today.

Hope this helps. 

On Thu, 2002-06-27 at 14:23, Chaoyang Deng wrote:
> Hi,
> 
> I am working on an iSCSI target driver with a Fibre Channel disk. After I
> updated my OS to linux7.3 with kernel 2.4.18-3, I got problem: my driver
> will crash my box. I am not sure if it is a bug in my code or in the
> Qlogic Fibre Channel driver or in the kernel. Could anyone give me a hint?

-- 
Austin Gonyou <austin@digitalroadkill.net>
