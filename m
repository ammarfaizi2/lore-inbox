Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265347AbRF0SSd>; Wed, 27 Jun 2001 14:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265350AbRF0SSX>; Wed, 27 Jun 2001 14:18:23 -0400
Received: from xd1.xdrive.com ([65.166.147.200]:53230 "HELO hellman.xman.org")
	by vger.kernel.org with SMTP id <S265347AbRF0SSH>;
	Wed, 27 Jun 2001 14:18:07 -0400
Date: Wed, 27 Jun 2001 11:16:08 -0700
From: Christopher Smith <x@xman.org>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>, Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
Message-ID: <53790000.993665768@hellman>
In-Reply-To: <20010627111827.A22744@pcep-jamie.cern.ch>
X-Mailer: Mulberry/2.0.8 (Linux/x86 Demo)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, June 27, 2001 11:18:28 +0200 Jamie Lokier 
<lk@tantalophile.demon.co.uk> wrote:
> Btw, this functionality is already available using sigaction().  Just
> search for a signal whose handler is SIG_DFL.  If you then block that
> signal before changing, checking the result, and unblocking the signal,
> you can avoid race conditions too.  (This is what my programs do).

It's more than whether a signal is blocked or not, unfortunately. Lots of 
applications will invoke sigwaitinfo() on whatever the current signal mask 
is, which means you can't rely on sigaction to solve your problems. :-(

--Chris
