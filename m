Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263133AbSJBO2c>; Wed, 2 Oct 2002 10:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263134AbSJBO2c>; Wed, 2 Oct 2002 10:28:32 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:59663
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263133AbSJBO2b>; Wed, 2 Oct 2002 10:28:31 -0400
Subject: Re: [PATCH] Re: Capabilities-related change in 2.5.40
From: Robert Love <rml@tech9.net>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021002132331.GA17376@nevyn.them.org>
References: <20021001164907.GA25307@nevyn.them.org>
	 <20021001134552.A26557@figure1.int.wirex.com>
	 <20021001211210.GA8784@nevyn.them.org>
	 <20021002003817.B26557@figure1.int.wirex.com>
	 <20021002132331.GA17376@nevyn.them.org>
Content-Type: text/plain
Organization: 
Message-Id: <1033569212.24108.20.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 02 Oct 2002 10:33:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 09:23, Daniel Jacobowitz wrote:

> How very odd.  I have been running 2.5 on that machine for a while, and
> the bug only showed up somewhere between 2.5.36 and 2.5.40.  Maybe a
> coincidence triggered by the PID hashing... your tabbing is a little
> odd but the patch looks right to me.  Thanks!

I too wonder if the bug is due to the pid changes and not me :)

find_task_by_pid(0) should just return current, which was my intention
to avoid conditional code-paths.  Maybe I should of used
find_process_by_pid()... it seems in the latest 2.5 that still returns
current if !pid, at least.

	Robert Love

