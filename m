Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWGHQrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWGHQrW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWGHQrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:47:22 -0400
Received: from mercury.realtime.net ([205.238.132.86]:49832 "EHLO
	ruth.realtime.net") by vger.kernel.org with ESMTP id S964897AbWGHQrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:47:21 -0400
In-Reply-To: <20060708084713.GA8020@mars.ravnborg.org>
References: <20060708084713.GA8020@mars.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b2ab6d298877aff62aa61e0430a16d3d@bga.com>
Content-Transfer-Encoding: 7bit
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] Use target filename in BUG_ON and friends
Date: Sat, 8 Jul 2006 11:45:49 -0500
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.624)
X-Server: High Performance Mail Server - http://surgemail.com r=-1092531819
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

			
On Jul 8, 2006, at 04:45:54 EST, Sam Ravnborg wrote:
>  When building the kernel using make O=.. all uses of __FILE__ becomes
>  filenames with absolute path resulting in increased text size.
>  Following patch supply the target filename as a commandline define
>  KBUILD_TARGET_FILE="mmslab.o"

Unfortunately this ignores the fact that __LINE__ is meaningless
without __FILE__ because there are way too many BUGs in header
files.

Well, it does give us a hint as to which user of the header is
the problem one without going to System.map or objdump.

Even though it is hard on ccache, it is nice to be able to cut
and paste the file name.

milton

