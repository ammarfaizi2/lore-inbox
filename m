Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267810AbTBRM6v>; Tue, 18 Feb 2003 07:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267809AbTBRM5o>; Tue, 18 Feb 2003 07:57:44 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:12195 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id <S267810AbTBRM5g>; Tue, 18 Feb 2003 07:57:36 -0500
Subject: Re: Help !! calling function in module from a user program
From: Alex Bennee <kernel-hacker@bennee.com>
To: Sudharsan Vijayaraghavan <svijayar@cisco.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4.3.2.7.2.20030218181634.01fb5428@desh>
References: <4.3.2.7.2.20030218181634.01fb5428@desh>
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1045573251.2505.108.camel@cambridge.braddahead>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1-1mdk 
Date: 18 Feb 2003 13:00:51 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 12:50, Sudharsan Vijayaraghavan wrote:
> Hi,
> 
> Am a new bee to linux internals.
> I am trying to make a simple program witch will call a function from a 
> module. I made a module compiled it and INSMOD-it into kernel, that works 
> fine. I would like to call from my user program a function defined in my 
> kernel module.

You never call functions directly from user-mode. You generally use a
syscall to interface between user-mode and kernel-mode. Most drivers
implement operations that map via these syscalls (i.e.
open/close/read/write etc). 

What exactly are you trying to achieve?
-- 
Alex, homepage: http://www.bennee.com/~alex/

How much does it cost to entice a dope-smoking UNIX system guru to Dayton?
		-- Brian Boyle, UNIX/WORLD's First Annual Salary Survey

