Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313756AbSDHVZF>; Mon, 8 Apr 2002 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313757AbSDHVZE>; Mon, 8 Apr 2002 17:25:04 -0400
Received: from zero.tech9.net ([209.61.188.187]:35601 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313756AbSDHVZE>;
	Mon, 8 Apr 2002 17:25:04 -0400
Subject: Re: system call for finding the number of cpus??
From: Robert Love <rml@tech9.net>
To: "Kuppuswamy, " Priyadarshini <Priyadarshini.Kuppuswamy@compaq.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6B003D25ADBDE347B5542AFE6A55B42E01A4451A@tayexc13.americas.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 08 Apr 2002 17:25:08 -0400
Message-Id: <1018301108.913.167.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-08 at 17:18, Kuppuswamy, Priyadarshini wrote:

>   I have a script that is using the /cpu/procinfo file to determine the
>  number of cpus present in the system. But I would like to implement it 
> using a system call rather than use the environment variables?? I couldn't
> find a system call for linux that would give me the result. Could anyone
> please let me know if there is one for redhat linux??

Linux does not implement such a syscall.  Note

	cat /proc/cpuinfo | grep processor | wc -l

works and is simple; you do not have to do it via script - execute it in
your C program, save the one-line output, and atoi() it.

	Robert Love

