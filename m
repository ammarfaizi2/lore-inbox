Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267347AbTACAOB>; Thu, 2 Jan 2003 19:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTACAOA>; Thu, 2 Jan 2003 19:14:00 -0500
Received: from holomorphy.com ([66.224.33.161]:51398 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267347AbTACAN6>;
	Thu, 2 Jan 2003 19:13:58 -0500
Date: Thu, 2 Jan 2003 16:22:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: __NR_exit_group for 2.4-O(1)
Message-ID: <20030103002219.GW9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030103001522.GA1539@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030103001522.GA1539@werewolf.able.es>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 01:15:22AM +0100, J.A. Magallon wrote:
> Hi all...
> I am running glibc-2.3.1 on top of a hacked 2.4.21-pre2+aa, and all programs
> show a curious message at exit when straced:
> strace ls:
> ...
> SYS_252(0, 0x1000, 0x156ad360, 0x156ae824, 0) = -1 ENOSYS (Function not implemented)
> _exit(0)                                = ?
> 252 is __NR_exit_group. I can not recover anything about this on MARC, is there
> any pointer to that for 2.4 ? Is it in -ac kernels ?
> BTW: I remember to see some posts about this, but _how_ can I make the search
> engine in MARC to do _not_ convert underscores to spaces ("exit_group" ->
> "exit group", and results not be half the posts in LKML) ???

This is probably threading-related. They're trying to exit the program
as a whole so exit_group() (by divination) would appear to be something
that exits an entire thread group instead of that task alone.

It's probably somewhere in 2.5.x kernel source.

Bill
