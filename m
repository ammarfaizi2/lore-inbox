Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKBEkq>; Wed, 1 Nov 2000 23:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129207AbQKBEk1>; Wed, 1 Nov 2000 23:40:27 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:43161 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S129130AbQKBEkY>;
	Wed, 1 Nov 2000 23:40:24 -0500
Message-ID: <20001102124020.A19735@saw.sw.com.sg>
Date: Thu, 2 Nov 2000 12:40:20 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: "Michael O'Donnell" <mod@mclinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100: card reports no resources [was VM-global...]
In-Reply-To: <20001031132306.A24147@stormix.com> <200010311932.OAA30422@odonnell.lowell.mclinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <200010311932.OAA30422@odonnell.lowell.mclinux.com>; from "Michael O'Donnell" on Tue, Oct 31, 2000 at 02:32:44PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 31, 2000 at 02:32:44PM -0500, Michael O'Donnell wrote:
[snip]
> Also, here's a possibly useless personal note WRT the
> eepro100 resource msgs, FWIW: I was recently using remote
> KGDB to work on an unrelated problem on an MP Pentium
> box with integrated eepro100.  Whenever I'd leave one CPU
> stopped in the kernel debugger for a very long time I'd
> get those "no resource" messages from (I believe it was)
> the Enet driver when I finally allowed that CPU to continue
> running.  I never noticed any other ill effects though
> I wasn't looking too hard for them at the time.  I don't

It may be a legitimate case of "no resource" messages: the receive ring
is full because interrupts aren't served for a long time.
The problem is spurious "no resource" conditions, when there are plenty of
ready buffers.

Best regards
		Andrey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
