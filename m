Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319271AbSIKS2c>; Wed, 11 Sep 2002 14:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319272AbSIKS2c>; Wed, 11 Sep 2002 14:28:32 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:34531 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319271AbSIKS2b> convert rfc822-to-8bit; Wed, 11 Sep 2002 14:28:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Xuan Baldauf <xuan--reiserfs@baldauf.org>,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: Heuristic readahead for filesystems
Date: Wed, 11 Sep 2002 20:30:27 +0200
User-Agent: KMail/1.4.1
Cc: Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
       Reiserfs List <reiserfs-list@namesys.com>
References: <Pine.LNX.4.44L.0209111340060.1857-100000@imladris.surriel.com> <3D7F83BC.5DF306A@baldauf.org>
In-Reply-To: <3D7F83BC.5DF306A@baldauf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209112030.27269.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In theory, this also could be implemented explicitly if the application
> could tell the kernel "I'm going to read these 100 files in the very
> near future, please make them ready for me". But wait, maybe the
> application can do this (for regular files, not for directory entries
> and stat() data): Could it be efficient if the application used
> open(file,O_NONBLOCK) for the next 100 files and subsequent read()s on
> each of the returned filedescriptors?

What do you want to trigger the reading ahead, open() or read() ?
Please correct me, if I am wrong, but wouldn't read() block ?

Aio should be able to do it. But even that want help you with the stat data.

	Regards
		Oliver

