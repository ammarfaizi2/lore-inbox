Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131730AbRDDBxq>; Tue, 3 Apr 2001 21:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132729AbRDDBxg>; Tue, 3 Apr 2001 21:53:36 -0400
Received: from cy57850-a.rdondo1.ca.home.com ([24.5.132.106]:63500 "HELO
	firewall.philstone.com") by vger.kernel.org with SMTP
	id <S131730AbRDDBx2>; Tue, 3 Apr 2001 21:53:28 -0400
Date: Tue, 03 Apr 2001 18:50:22 -0700
From: Christopher Smith <x@xman.org>
To: Fabio Riccardi <fabio@chromium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a quest for a better scheduler
Message-ID: <101220000.986349022@hellman>
In-Reply-To: <3ACA7629.E8C54D13@chromium.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86 Demo)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, April 03, 2001 18:17:30 -0700 Fabio Riccardi 
<fabio@chromium.com> wrote:
> Alan Cox wrote:
> Indeed, I'm using RT sigio/sigwait event scheduling, bare clone threads
> and zero-copy io.

Fabio, I'm working on a similar solution, although I'm experimenting with 
SGI's KAIO patch to see what it can do. I've had to patch the kernel to 
implement POSIX style signal dispatch symantics (so that the thread which 
posted an I/O request doesn't have to be the one which catches the signal). 
Are you taking a similar approach, or is the lack of this behavior the 
reason you are using so many threads?

--Chris
