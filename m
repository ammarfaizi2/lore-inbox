Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbTHaWwI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbTHaWv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:51:29 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:62916 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263033AbTHaWtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:49:23 -0400
Subject: Re: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: "Zach, Yoav" <yoav.zach@intel.com>, akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030831221230.GA9725@DUK2.13thfloor.at>
References: <2C83850C013A2540861D03054B478C0601CF64C8@hasmsx403.iil.intel.com>
	 <20030831221230.GA9725@DUK2.13thfloor.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062370098.12058.5.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 23:48:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-31 at 23:12, Herbert Poetzl wrote:
> what non-readable files need to be interpreted/executed?
> why is this case relevant?
> why not simply make it user-land readable?

If you are running binaries for another architecture via software
emulation (for example qemu running x86 binaries on your S/390 
transparently) then you want exec only binaries to work with an
otherwise trusted interpreter [Getting the interpreter trust stuff
right is really hard btw - so ironically it probably has to be setuid
anyway so you can't steal the handle]


