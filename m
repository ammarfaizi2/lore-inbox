Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319281AbSIKTCN>; Wed, 11 Sep 2002 15:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319291AbSIKTCN>; Wed, 11 Sep 2002 15:02:13 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:64197 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319281AbSIKTCM> convert rfc822-to-8bit; Wed, 11 Sep 2002 15:02:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Xuan Baldauf <xuan--reiserfs@baldauf.org>
Subject: Re: Heuristic readahead for filesystems
Date: Wed, 11 Sep 2002 21:04:41 +0200
User-Agent: KMail/1.4.1
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0209111340060.1857-100000@imladris.surriel.com> <200209112030.27269.oliver@neukum.name> <3D7F8ECA.21086A5@baldauf.org>
In-Reply-To: <3D7F8ECA.21086A5@baldauf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209112104.41987.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 11. September 2002 20:43 schrieb Xuan Baldauf:

> > Please correct me, if I am wrong, but wouldn't read() block ?
>
> AFAIK, "man open" tells
>
> [...]
>       int open(const char *pathname, int flags);
> [...]
>        O_NONBLOCK or O_NDELAY
>                The file is opened in non-blocking mode. Neither the open
> nor any __subsequent__ operations  on  the  file  descriptor
>                which is returned will cause the calling process to wait.
> [...]
>
> So read won't block if the file has been opened with O_NONBLOCK.

Well, so the man page tells you. The kernel sources tell otherwise, unless
I am badly mistaken.

> > Aio should be able to do it. But even that want help you with the stat
> > data.
>
> Aio would help me announcing stat() usage for the future?

No, it won't. But it would solve the issue of reading ahead.
Stating needs a kernel implementation of 'stat ahead'
