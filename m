Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278657AbRJSUoE>; Fri, 19 Oct 2001 16:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278658AbRJSUnz>; Fri, 19 Oct 2001 16:43:55 -0400
Received: from [213.96.124.18] ([213.96.124.18]:7147 "HELO dardhal")
	by vger.kernel.org with SMTP id <S278657AbRJSUnr>;
	Fri, 19 Oct 2001 16:43:47 -0400
Date: Fri, 19 Oct 2001 22:47:21 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Case where VM of 2.4.13pre2aa falls apart
Message-ID: <20011019224721.B1464@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <DD0DC14935B1D211981A00105A1B28DB05298FB8@NL-ASD-EXCH-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DD0DC14935B1D211981A00105A1B28DB05298FB8@NL-ASD-EXCH-1>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 19 October 2001, at 02:39:00 -0500,
Leeuw van der, Tim wrote:

> Hello,
> 
> I've observed a case where the VM of 2.4.13pre2aa totally falls apart. I
> know it's not the latest of Andrea's VM tweaks, but I didn't yet get a
> chance to compile&reboot into a later version. I've noticed a similar
> breakdown in one of the first pre-release kernels with the Andrea VM, btw.
> [...description of problem apparently related to Mozilla ...]
>
Maybe what happens here doesn't have anything in common with what you
experienced, but a couple of days ago I suffered a full X server crash due
to a _big_ memory leak with Mozilla in one specific web page.

Linux kernel 2.4.12, Mozilla 0.9.5, and X 4.1.0. Open
www.securityfocus.org with Mozilla. For a couple of minutes, it seems that
all is going on nicely. Afterwards, and without any kind of user
interaction with Mozilla, both mozilla and X processes start increasing
their sizes, slowly, but steadily.

After some minutes of memory "leaking", either Mozilla crashes itself (no
OOM as far as /var/log/kern.log says), leaving X process with a big SIZE
(the same it had just before Mozilla crashed), or the whole X session
crahses.

Bug number 101461 on bugzilla.mozilla.org describes this problem with
Mozilla and www.securityfocus.org. Maybe this behaviour can be triggered
from some other web sites, and maybe it doesn't have anything in common
with your problems, but maybe it is worth a try.

--
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

