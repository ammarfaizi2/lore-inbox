Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263109AbSJGQJ3>; Mon, 7 Oct 2002 12:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSJGQJ3>; Mon, 7 Oct 2002 12:09:29 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:29714 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S263109AbSJGQJ2>;
	Mon, 7 Oct 2002 12:09:28 -0400
Date: Mon, 7 Oct 2002 16:14:48 +0000
From: Eduardo =?iso-8859-1?Q?P=E9rez?= <100018135@alumnos.uc3m.es>
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] namespace clean
Message-ID: <bc48ec9d071bba9d72027b816cca42d5@alumnos.uc3m.es>
References: <a6cf5427338512cb0ae6b015e16b896a@alumnos.uc3m.es> <3DA1A532.9BF70424@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DA1A532.9BF70424@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-07 08:16:02 -0700, george anzinger wrote:
> Eduardo Pérez wrote:
> > Currently the Linux kernel has a cryptic api namespace that confuses
> > many people when trying to code for the Linux kernel. People can't know
> > by direct examination of a symbol to what package belongs. Also symbols
> > can't be easily sorted by package.
> > 
> > I'm suggesting to use a cleaner namespace like
> > package_object_method and package_function
> > If this is accepted, symbols from new code should follow this
> > naming, and current symbols should start the transition to this cleaner
> > namespace.
> > 
> > If anybody like me think that this would help people to code for the
> > Linux kernel it would be a good idea to start this transition to a
> > cleaner namespace.
> > 
> > Most drivers and new core kernel api have a very clean namespace but
> > some old api don't.
> > 
> > What are your thoughts about this ?
> 
> Then if it is a static symbol, one could use anything?  I.e.
> static symbols would not follow the rule, right?

Yes, static symbols don't need to be prefixed as they are not public api
It's a good idea to have them prefixed if you want to search for them in
a sorted symbol list or in System.map
