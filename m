Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278308AbRJMOx7>; Sat, 13 Oct 2001 10:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278309AbRJMOxu>; Sat, 13 Oct 2001 10:53:50 -0400
Received: from [212.21.93.146] ([212.21.93.146]:28291 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S278308AbRJMOxi>; Sat, 13 Oct 2001 10:53:38 -0400
Date: Sat, 13 Oct 2001 16:53:32 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011013165332.A20499@kushida.jlokier.co.uk>
In-Reply-To: <Pine.LNX.4.33.0110040842320.8350-100000@penguin.transmeta.com> <m1hetfz5ae.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1hetfz5ae.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Oct 04, 2001 at 11:25:13AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Trust me. The people who came up with MAP_COPY were stupid. Really. It's
> an idiotic concept, and it's not worth implementing.

I can think of an efficiency-related use for MAP_COPY, and it has
nothing to do with shared libraries:

 - An editor using mmap() to read a file.

The existing semantics require that you either call read() and waste
(potentially shared) memory to do this, or use MAP_PRIVATE and then
deliberately page in and dirty all of the file's pages.

Neither of these seem to be the most efficient way to launch an editor.

cheers,
-- Jamie
