Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129948AbQKEUSq>; Sun, 5 Nov 2000 15:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129946AbQKEUS1>; Sun, 5 Nov 2000 15:18:27 -0500
Received: from [194.213.32.137] ([194.213.32.137]:260 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129692AbQKEUSI>;
	Sun, 5 Nov 2000 15:18:08 -0500
Message-ID: <20001105211126.A146@bug.ucw.cz>
Date: Sun, 5 Nov 2000 21:11:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: >32K possible? Yes - on 1GB machine
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I played with machine with .5GB ram, and was able to spawn 16000
'sleep forever' processes (compiled statically):

void main(void)
{
	close(0); close(1); close(2); pause();
}

I belive that on 2GB machine, I'd be able to hit 32K processes
limit. 1GB machine _could_ hit it too (someone try that).

Strange thing is that machine does not even try to use swap, but
userland stops working at the end.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
