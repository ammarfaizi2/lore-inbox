Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbQKEN6y>; Sun, 5 Nov 2000 08:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQKEN6o>; Sun, 5 Nov 2000 08:58:44 -0500
Received: from Cantor.suse.de ([194.112.123.193]:60935 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129111AbQKEN6e>;
	Sun, 5 Nov 2000 08:58:34 -0500
Date: Sun, 5 Nov 2000 14:58:31 +0100
From: Andi Kleen <ak@suse.de>
To: bobyetman@att.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Loadavg calculation
Message-ID: <20001105145831.A29597@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0011050746090.634-100000@juryrig.worldnet.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011050746090.634-100000@juryrig.worldnet.att.net>; from bobyetman@att.net on Sun, Nov 05, 2000 at 07:55:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 07:55:40AM -0500, bobyetman@att.net wrote:
> 
> We'd like to reduce that almost 50 second lag time.  Is it possible, in
> user-space, to duplicate the loadavg calculation period, say to a 15
> second load average, using the information in /proc?

You could simply recompile the kernel with a smaller LOAD_FREQ constant.
It defines how often the average  computation runs. The unit is jiffies,
which is 10ms on i386. 
It may break some other programs though.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
