Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262205AbTCHVG3>; Sat, 8 Mar 2003 16:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbTCHVG3>; Sat, 8 Mar 2003 16:06:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:35505 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262205AbTCHVG2>;
	Sat, 8 Mar 2003 16:06:28 -0500
Date: Sat, 8 Mar 2003 13:17:21 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Console weirdness
Message-Id: <20030308131721.5254517a.akpm@digeo.com>
In-Reply-To: <3E6A1A7F.8090409@portrix.net>
References: <3E6A1A7F.8090409@portrix.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Mar 2003 21:16:59.0514 (UTC) FILETIME=[0E38C5A0:01C2E5B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer <j.dittmer@portrix.net> wrote:
>
> I'm not seeing any boot messages during boot up.

You have many different console drivers in your kernel.  Current -bk no
longer ensures that the VT console is the first-registered.  You are probably
now defaulting to serial console.

Try adding "console=/dev/tty0" to your kernel boot parameters.  Please
report on the outcome.

