Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312884AbSC0Btw>; Tue, 26 Mar 2002 20:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312925AbSC0Btm>; Tue, 26 Mar 2002 20:49:42 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:4547 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S312884AbSC0Btf>; Tue, 26 Mar 2002 20:49:35 -0500
Date: Tue, 26 Mar 2002 17:49:32 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Melkor Ainur <melkorainur@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: signal_pending() and schedule()
Message-ID: <20020327014932.GB803@insight.us.oracle.com>
In-Reply-To: <20020327001955.99099.qmail@web21203.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2002 at 04:19:55PM -0800, Melkor Ainur wrote:
> This works fine for some applications like netcat,etc
> but fails for netscape. In debugging this, I observe
> that after calling schedule_timeout(), the sigpending
> bit appears to be set immediately and thus 
> schedule() doesn't actually put the process to sleep.

	This is happening exactly for the reason you would expect it to:
A signal has arrived.  Netscape's userspace "threading" is based
entirely on signals.  Netscape sends itself SIGALRM almost continuously.
You'll have to expect this from Netscape and work around or with it.

Joel

-- 

Life's Little Instruction Book #337

	"Reread your favorite book."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
