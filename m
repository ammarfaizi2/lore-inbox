Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270017AbUJHPY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270017AbUJHPY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270019AbUJHPY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:24:27 -0400
Received: from findaloan.ca ([66.11.177.6]:35975 "EHLO findaloan.ca")
	by vger.kernel.org with ESMTP id S270017AbUJHPYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:24:22 -0400
Date: Fri, 8 Oct 2004 11:20:06 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041008152006.GA13183@mark.mielke.cc>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
References: <41658C03.6000503@nortelnetworks.com> <015f01c4acbe$cf70dae0$161b14ac@boromir> <4165B9DD.7010603@nortelnetworks.com> <20041007150035.6e9f0e09.davem@davemloft.net> <000901c4acc4$26404450$161b14ac@boromir> <20041007152400.17e8f475.davem@davemloft.net> <20041007224242.GA31430@mark.mielke.cc> <20041007154722.2a09c4ab.davem@davemloft.net> <20041007230019.GA31684@mark.mielke.cc> <20041008061052.GB2745@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008061052.GB2745@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 02:10:52AM -0400, Theodore Ts'o wrote:
> On Thu, Oct 07, 2004 at 07:00:19PM -0400, Mark Mielke wrote:
> > Just say "it's a bug, but one we have chosen not to fix for practical
> > reasons." That would have kept me out of this discussion. Saying the
> > behaviour is correct and that POSIX is wrong - that raises hairs -
> > both the question kind, and the concern kind.
> Why?  POSIX have gotten *lots* of things wrong in the past.  
> [ non-relevant complaints about POSIX ]
> What we do when POSIX does
> something idiotic is something that has to be addressed on a
> case-by-case basis.

In this case, POSIX defines select() / blocking read() to be useful.
Linux defines it to be dangerous.

I have no question in my mind which behaviour is 'correct', in this
case. Deciding between something that works, and something that doesn't,
is a no brainer for me. Talking about performance, and so on, is just a
complete distraction. Who cares about performance when a percentage of
the time the caller will be in a confused state as a result?

I'm ok with case-by-case. I'm not ok with a generic "POSIX sucks lots -
why should we be POSIX compliant?"

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

