Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSGBQra>; Tue, 2 Jul 2002 12:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316825AbSGBQr3>; Tue, 2 Jul 2002 12:47:29 -0400
Received: from s1.relay.oleane.net ([195.25.12.48]:27333 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S316824AbSGBQr3>; Tue, 2 Jul 2002 12:47:29 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Werner Almesberger <wa@almesberger.net>, Keith Owens <kaos@ocs.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Module removal
Date: Tue, 2 Jul 2002 18:50:19 +0200
Message-Id: <20020702165019.29700@smtp.adsl.oleane.com>
In-Reply-To: <20020702133658.I2295@almesberger.net>
References: <20020702133658.I2295@almesberger.net>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It's not really just the module information. If I can, say, get
>> callbacks from something even after I unregister, I may well
>> have destroyed the data I need to process the callbacks, and
>> oops or worse.
>
>Actually, if module exit synchronizes properly, even the
>return-after-removal case shouldn't exist, because we'd simply
>wait for this call to return.
>
>Hmm, interesting. Did I just make the whole problem go away,
>or is travel fatigue playing tricks on my brain ? :-)

That was one of the solutions proposed by Rusty, that is basically
waiting for all CPUs to have scheduled upon exit from module_exit
and before doing the actual removal.

Ben.


