Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292931AbSCPEK3>; Fri, 15 Mar 2002 23:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292975AbSCPEKT>; Fri, 15 Mar 2002 23:10:19 -0500
Received: from relay1.pair.com ([209.68.1.20]:64270 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S292931AbSCPEKI>;
	Fri, 15 Mar 2002 23:10:08 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C92C818.3B7E370A@kegel.com>
Date: Fri, 15 Mar 2002 20:20:40 -0800
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>
Subject: Re: libc/1427: gprof does not profile threads 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri Mar 15, 2002 at 04:19:17PM -0800, Ulrich Drepper wrote:
> > On Fri, 2002-03-15 at 13:56, Dan Kegel wrote:
> > > Ulrich, do you at least agree that it would be desirable for
> > > gprof to work properly on multithreaded programs?
> >
> > No.  gprof is uselss in today world.
> 
> Then why not change sysdeps/generic/initfini.c with something like:
> 
> -      if (gmon_start)
> +      if (gmon_start && __pthread_initialize_minimal)
>           gmon_start ();
> 
> So it doesn't even try when threading?

I believe Ulrich's proposed fix would be

> -      if (gmon_start)
> +      if (gmon_start && 0)
>           gmon_start ();

as he did not distinguish between threaded and nonthreaded programs
when he said gprof was useless.

- Dan
