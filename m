Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSLTPfP>; Fri, 20 Dec 2002 10:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSLTPfP>; Fri, 20 Dec 2002 10:35:15 -0500
Received: from crack.them.org ([65.125.64.184]:57319 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262420AbSLTPfO>;
	Fri, 20 Dec 2002 10:35:14 -0500
Date: Fri, 20 Dec 2002 10:44:13 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Christoph Hellwig <hch@infradead.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: PTRACE_GET_THREAD_AREA
Message-ID: <20021220154413.GA17007@nevyn.them.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>
References: <200212200832.gBK8Wfg29816@magilla.sf.frob.com> <20021220102431.A26923@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220102431.A26923@infradead.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 10:24:31AM +0000, Christoph Hellwig wrote:
> On Fri, Dec 20, 2002 at 12:32:41AM -0800, Roland McGrath wrote:
> > This patch vs 2.5.51 (should apply fine to 2.5.52) adds two new ptrace
> > requests for i386, PTRACE_GET_THREAD_AREA and PTRACE_SET_THREAD_AREA.
> > These let another process using ptrace do the equivalent of performing
> > get_thread_area and set_thread_area system calls for another thread.
> 
> I don't think ptrace is the right interface for this.  Just changed
> the get_thread_area/set_thread_area to take a new first pid_t argument.
> 
> Of course you might have to check privilegues if the first argument is
> non-null (i.e. not yourself).

I have to disagree.  These are things which you should never do to
another process unless you're ptracing them; get_thread_area with a PID
is not generally useful.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
