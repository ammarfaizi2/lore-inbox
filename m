Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280856AbRKTDeX>; Mon, 19 Nov 2001 22:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280863AbRKTDeN>; Mon, 19 Nov 2001 22:34:13 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:21146 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280856AbRKTDeB>;
	Mon, 19 Nov 2001 22:34:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Swap
Date: Mon, 19 Nov 2001 19:33:47 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33L.0111191642390.1491-100000@duckman.distro.conectiva> <m1k7wm6trd.fsf@frodo.biederman.org>
In-Reply-To: <m1k7wm6trd.fsf@frodo.biederman.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E1661fQ-0001UQ-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 19, 2001 18:49, Eric W. Biederman wrote:
> That would probably do it.  Though it is puzzling why after the file
> is munmaped it's pages aren't recycled.

Because they're part of the page cache now, and won't be recycled until newer 
pages 'push' them out of memory. I for one would be very annoyed an mmap()'s 
associated cache was dropped immediately on munmap, there are many instances 
in which it would be reused immediately after (think running two GTK+ apps in 
a row, and having to reload libgtk from disk each time).

-Ryan
