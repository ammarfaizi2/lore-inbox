Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbSIXSom>; Tue, 24 Sep 2002 14:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261749AbSIXSom>; Tue, 24 Sep 2002 14:44:42 -0400
Received: from pr-66-150-46-254.wgate.com ([66.150.46.254]:52956 "EHLO
	mail.tvol.net") by vger.kernel.org with ESMTP id <S261748AbSIXSok>;
	Tue, 24 Sep 2002 14:44:40 -0400
Message-ID: <3D90B3D1.30405@wgate.com>
Date: Tue, 24 Sep 2002 14:49:53 -0400
From: Michael Sinz <msinz@wgate.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.1b) Gecko/20020813
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Peter Svensson <petersv@psv.nu>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>,
       Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org,
       ingo Molnar <mingo@redhat.com>
Subject: Re: Offtopic: (was Re: [ANNOUNCE] Native POSIX Thread Library 0.1)
References: <Pine.LNX.4.44L.0209241329590.15154-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Tue, 24 Sep 2002, Peter Svensson wrote:
> 
> 
>>For raytracers (which was the example) you need almost no coordination at
>>all. Just partition the scene and you are done. This is going offtopic
>>fast. The point I was making is that there is really no great reward in
>>grouping threads. Either you need to educate your users and trust them to
>>behave, or you need per user scheduling.
> 
> 
> I've got per user scheduling.  I'm currently porting it to 2.4.19
> (and having fun with some very subtle bugs) and am thinking about
> how to port this beast to the O(1) scheduler in a clean way.
> 
> Note that it's not necessarily per user, it's trivial to adapt
> the code to use any other resource container instead.

Doing it per process prevents some class of problems.  Doing it
per user prevents another class.

Note that this does not limit the user (ulimit type solutions)
when the system is not under stress.  What it does do is make sure
that no one user (or process) can DOS the system.  In other words,
implement a fairness amoung peers (users or processes).

Currently, Linux has fairness amoung threads (since threads and
processes are basically the same as far as the scheduler is
concerned.)

I would be interested in seeing this patch.  A per process thing
would be really cool for what I am building (WorldGate) since
many of the processes are all running as the same user but a per
user thing would also be interesting.

(Or both - processes within a user are fair with each other and
users are fair amoung the other users...)

-- 
Michael Sinz -- Director, Systems Engineering -- Worldgate Communications
A master's secrets are only as good as
	the master's ability to explain them to others.


