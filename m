Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274180AbRIXV4s>; Mon, 24 Sep 2001 17:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274179AbRIXV4j>; Mon, 24 Sep 2001 17:56:39 -0400
Received: from pc-62-30-67-185-az.blueyonder.co.uk ([62.30.67.185]:26606 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S274178AbRIXV4b>; Mon, 24 Sep 2001 17:56:31 -0400
Date: Mon, 24 Sep 2001 22:56:16 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Gordon Oliver <gordo@pincoya.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Kegel <dank@kegel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] /dev/epoll update ...
Message-ID: <20010924225616.D9688@kushida.jlokier.co.uk>
In-Reply-To: <20010924203406.B9688@kushida.jlokier.co.uk> <XFMail.20010924130908.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010924130908.davidel@xmailserver.org>; from davidel@xmailserver.org on Mon, Sep 24, 2001 at 01:09:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > You could even keep the memory for the queued signal / event inside
the file structure.
> 
> By keeping the event structure inside the file* require you to collect
> these events ( read memory moves ) at peek time.
> With /dev/epoll the event is directly dropped inside the mmaped area.

Well, memory move consists of 2 words: (a) file descriptor; (b) poll
state/edge flags.

That will be completely swamped by the system calls and so on needed to
processes each of the file descriptors.  I.e. no scalability problem here.

-- Jamie
