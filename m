Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUJHGOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUJHGOv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 02:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUJHGOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 02:14:50 -0400
Received: from [69.25.196.29] ([69.25.196.29]:11420 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264984AbUJHGOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 02:14:02 -0400
Date: Fri, 8 Oct 2004 02:10:52 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "David S. Miller" <davem@davemloft.net>, msipkema@sipkema-digital.com,
       cfriesen@nortelnetworks.com, hzhong@cisco.com, jst1@email.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041008061052.GB2745@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"David S. Miller" <davem@davemloft.net>,
	msipkema@sipkema-digital.com, cfriesen@nortelnetworks.com,
	hzhong@cisco.com, jst1@email.com, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk, davem@redhat.com
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com> <41658C03.6000503@nortelnetworks.com> <015f01c4acbe$cf70dae0$161b14ac@boromir> <4165B9DD.7010603@nortelnetworks.com> <20041007150035.6e9f0e09.davem@davemloft.net> <000901c4acc4$26404450$161b14ac@boromir> <20041007152400.17e8f475.davem@davemloft.net> <20041007224242.GA31430@mark.mielke.cc> <20041007154722.2a09c4ab.davem@davemloft.net> <20041007230019.GA31684@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007230019.GA31684@mark.mielke.cc>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 07:00:19PM -0400, Mark Mielke wrote:
> 
> Just say "it's a bug, but one we have chosen not to fix for practical
> reasons." That would have kept me out of this discussion. Saying the
> behaviour is correct and that POSIX is wrong - that raises hairs -
> both the question kind, and the concern kind.

Why?  POSIX have gotten *lots* of things wrong in the past.  

For example, using 512 byte units for df and du (which we ignore, and
for which the POSIX will hopefully eventually catch up with sanity)
and fcntl unlocking semantics (which we adhere to despite the fact
that is broken beyond belief, and very likely will and will continue
to cause application bugs in the feature).  What we do when POSIX does
something idiotic is something that has to be addressed on a
case-by-case basis.

						- Ted
