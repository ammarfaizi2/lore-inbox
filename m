Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUJINzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUJINzM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 09:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUJINzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 09:55:12 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:62377 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266880AbUJINzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 09:55:08 -0400
Subject: Re: Inconsistancies in /proc (status vs statm) leading to wrong
	documentation (proc.txt)
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: eric.valette@free.fr
Content-Type: text/plain
Organization: 
Message-Id: <1097329771.2674.4036.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Oct 2004 09:49:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette writes:

> I'm currently trying use mlockall for a soft RT application and was 
> concerned by the memory usage of my (big) RT process. So I stated to
> look at /proc/<PID>/status and /proc/<PID>/statm and then to the  
> documentation of statm (Documentation/filesystem/proc.txt) because
> unexplained values are rather useless.
>
> The doc currently says :
> -------------------------------------------------------------------------
>   Field    Content
>   size     total program size (pages)  (same as VmSize in status)

The documentation is incorrect. It was written to match a buggy
implementation in early 2.6.x kernels.

VmSize is the address space occupied, excluding memory-mapped IO.
The statm value is the address space occupied.

> May I suggest :
>  - To use consistent memory size units between status and statm,

No way. This would instantly break the "top" program.


