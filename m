Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281932AbRLVTBu>; Sat, 22 Dec 2001 14:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282082AbRLVTBl>; Sat, 22 Dec 2001 14:01:41 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:45063 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281932AbRLVTB1>; Sat, 22 Dec 2001 14:01:27 -0500
Date: Sat, 22 Dec 2001 14:01:26 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing
Message-ID: <20011222140126.B19442@redhat.com>
In-Reply-To: <8727.1009020535@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8727.1009020535@kao2.melbourne.sgi.com>; from kaos@sgi.com on Sat, Dec 22, 2001 at 10:28:55PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2001 at 10:28:55PM +1100, Keith Owens wrote:
> The patch below dynamically assigns a syscall number to a name and
> exports the number and name via /proc.  Dynamic assignment removes the
> collision problem.  Exporting via /proc allows user space code to
> automatically find out what the syscall number is this week.  strace
> could read the /proc output to print the syscall name, although it
> still cannot print the arguments.

Doesn't work.  You've still got problems running binaries compiled against 
newer kernels (say, glibc supporting a new syscall) against the dynamic 
syscall.  Numbers don't work, plain and simple.

		-ben
