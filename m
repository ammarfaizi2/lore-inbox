Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRDBM4X>; Mon, 2 Apr 2001 08:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRDBM4N>; Mon, 2 Apr 2001 08:56:13 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:64783 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129078AbRDBM4H>; Mon, 2 Apr 2001 08:56:07 -0400
Date: Mon, 2 Apr 2001 09:54:25 -0300
From: Gustavo Niemeyer <niemeyer@conectiva.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pthreads & fork & execve
Message-ID: <20010402095425.A15554@tux.distro.conectiva>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01033016225700.00409@dennis> <Pine.LNX.4.21.0104021338320.8447-100000@bellatrix.tat.physik.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <Pine.LNX.4.21.0104021338320.8447-100000@bellatrix.tat.physik.uni-tuebingen.de>; from rguenth@tat.physik.uni-tuebingen.de on Mon, Apr 02, 2001 at 01:42:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard! Hi Dennis!

> I tracked this down to a corrupt jumptable somewhere in the pthreads
> part of the libc (didnt have the source handy at that time, though). So
> I think this is a libc bug (version does not matter) - I even did a
> followup to a similar bug in the libc gnats database (I think I should
> have opened a new one, though...). But I failed to construct a "simple"
> testcase showing the bug (We use rather large amount of threads and
> in one or two doing popen() calls - or handcrafted fork() && execv(),
> the SIGSEGV is during fork()).

We're going trough two similar problems here. One is KDE, and the other
is Linuxconf. Linuxconf is core dumping on a module when it is linked
with pthread and dlopen()'ed with RTLD_GLOBAL. We must reduce one of
them to a testcase.

Btw, both are mainly C++ programs. Is your software written in C++?

> I stopped trying to find out what is going on as this feature is not
> essential (but maybe useful in the future). So I suggest you build a
> libc from source with debugging on and trace it down to the actual
> libc problem - or better try to isolate a simple testcase.

We'll probably do this here...

> I like to hear from the results :)

Please, let me know as well! :-)

Thanks!!

-- 
Gustavo Niemeyer

[ 2AAC 7928 0FBF 0299 5EB5  60E2 2253 B29A 6664 3A0C ]
