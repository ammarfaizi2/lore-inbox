Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTKWWJp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 17:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbTKWWJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 17:09:45 -0500
Received: from zork.zork.net ([64.81.246.102]:40136 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S263479AbTKWWJo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 17:09:44 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Coredump file
References: <000c01c3b20b$a4857560$34dfa7c8@bsb.virtua.com.br>
Reply-To: Sean Neakums <sneakums@zork.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 23 Nov 2003 22:09:43 +0000
In-Reply-To: <000c01c3b20b$a4857560$34dfa7c8@bsb.virtua.com.br> (brenosp@brasilsec.com.br's
 message of "Sun, 23 Nov 2003 19:49:15 -0200")
Message-ID: <6ud6birb2w.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Breno" <brenosp@brasilsec.com.br> writes:

> How can I generate a coredump file ?
> I tryed to force a signal "Quit" , using ^\ , but didn´t work.

Here are some possible reasons for this:

* the core dump ulimit may be set too low (check this with ulimit -c)
* you do not have write permission for the process's cwd
* there is a core file in the process's cwd that you do not own

