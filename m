Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311284AbSCLQn6>; Tue, 12 Mar 2002 11:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289484AbSCLQnv>; Tue, 12 Mar 2002 11:43:51 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:18076 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S311283AbSCLQnl>;
	Tue, 12 Mar 2002 11:43:41 -0500
Date: Tue, 12 Mar 2002 11:42:52 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Tachino Nobuhiro <tachino@jp.fujitsu.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>, torvalds@transmeta.com,
        Jeff Jenkins <jefreyr@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: [bkpatch] Multiple threads in core dumps (was: Re: Thread
Message-ID: <20020312114252.A26117@nevyn.them.org>
Mail-Followup-To: Tachino Nobuhiro <tachino@jp.fujitsu.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Vamsi Krishna S." <vamsi_krishna@in.ibm.com>,
	torvalds@transmeta.com, Jeff Jenkins <jefreyr@pacbell.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <eliqqvfh.wl@nisaaru.dvs.cs.fujitsu.co.jp> <E16kkC8-0003QG-00@the-village.bc.nu> <it8211u5.wl@nisaaru.dvs.cs.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <it8211u5.wl@nisaaru.dvs.cs.fujitsu.co.jp>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 08:07:30PM +0900, Tachino Nobuhiro wrote:
> 
> Hello,
> 
> At Tue, 12 Mar 2002 11:11:52 +0000 (GMT),
> Alan Cox wrote:
> > 
> > > I am now trying to implement gcore system call on linux and have a 
> > > great interest in your patch.
> > 
> > The old Berkeley gcore wasnt a system call nor did it need to be. Ptrace
> > (and in their case grovelling around in /dev/mem) is more than sufficient
> 
>   IMHO, implementing gcore with ptrace has some problems, I think. If the process sleeps
>   with TASK_UNINTERRUPTIBLE, almost ptrace() calls fails. If the process is already traced,
>   you cannot use ptrace().

GDB implements gcore entirely via ptrace.  Are there really so many
cases where that is inadequate?  And the second objection (and maybe
the first) may go away if/when David Howells' new debugging interface
is ready.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
