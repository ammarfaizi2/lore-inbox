Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264397AbRFNBuI>; Wed, 13 Jun 2001 21:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264393AbRFNBt6>; Wed, 13 Jun 2001 21:49:58 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:37132 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S264394AbRFNBtr>; Wed, 13 Jun 2001 21:49:47 -0400
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
Message-ID: <992483368.3b281828dde02@eargle.com>
Date: Wed, 13 Jun 2001 21:49:28 -0400 (EDT)
From: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Tom Sightler <ttsig@tuxyturvy.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106131716510.1742-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33.0106131716510.1742-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rik van Riel <riel@conectiva.com.br>:

> After the initial burst, the system should stabilise,
> starting the writeout of pages before we run low on
> memory. How to handle the initial burst is something
> I haven't figured out yet ... ;)

Well, at least I know that this is expected with the VM, although I do still
think this is bad behavior.  If my disk is idle why would I wait until I have
greater than 100MB of data to write before I finally start actually moving some
data to disk?
 
> This is due to this smarter handling of the flushing of
> dirty pages and due to a more subtle bug where the system
> ended up doing synchronous IO on too many pages, whereas
> now it only does synchronous IO on _1_ page per scan ;)

And this is definately a noticeable fix, thanks for your continued work.  I know
it's hard to get everything balanced out right, and I only wrote this email to
describe some behavior I was seeing and make sure it was expected in the current
VM.  You've let me know that it is, and it's really minor compared to problems
some of the earlier kernels had.

Later,
Tom

