Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293167AbSCFDzM>; Tue, 5 Mar 2002 22:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293175AbSCFDzC>; Tue, 5 Mar 2002 22:55:02 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:27406 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293167AbSCFDyy>; Tue, 5 Mar 2002 22:54:54 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 5 Mar 2002 19:58:24 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: a faster way to gettimeofday?
In-Reply-To: <3C859007.50102@candelatech.com>
Message-ID: <Pine.LNX.4.44.0203051955090.1475-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Ben Greear wrote:

> I have a program that I very often need to calculate the current
> time, with milisecond accuracy.  I've been using gettimeofday(),
> but gprof shows it's taking a significant (10% or so) amount of
> time.  Is there a faster (and perhaps less portable?) way to get
> the time information on x86?  My program runs as root, so should
> have any permissions it needs to use some backdoor hack if that
> helps!

If you're on x86 you can use collect rdtsc samples and convert them to ms.
You'll get even more then ms accuracy.




- Davide



