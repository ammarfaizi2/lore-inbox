Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbTHTBM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 21:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbTHTBM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 21:12:58 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:48276
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261674AbTHTBM5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 21:12:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O17int
Date: Wed, 20 Aug 2003 11:19:40 +1000
User-Agent: KMail/1.5.3
References: <200308200102.04155.kernel@kolivas.org> <yw1xbrulxyn8.fsf@users.sourceforge.net>
In-Reply-To: <yw1xbrulxyn8.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308201119.41093.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003 04:58, Måns Rullgård wrote:
> Another XEmacs strangeness:
>
> When compiling from xemacs, everything is fine until the compilation
> is done.  Then xemacs starts spinning wildly in some loop doing this:
> This goes on for anything from half a second to several seconds.
> During that time other processes, except X, are starved.
>
> I saw this first with 2.6.0-test1 vanilla, then it went away in -test2
> and -test3, only to show up again with O16.3int.  My O16.2 kernel
> seems ok, which seems strange to me since the difference from O16.2 to
> O16.3 is very small.

While being a small patch, 16.2-16.3 was a large change. It removed the very 
aggressive starvation avoidance of spin on wait waker/wakee in 16.2, which 
clearly helped your issue.

> Any ideas?

Pretty sure we have another spinner. A reniced -11 batch run of top -d 1 and 
vmstat during the spinning, and a kernel profile for that time will be 
helpful.

Con

