Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317340AbSGTDxg>; Fri, 19 Jul 2002 23:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317342AbSGTDxg>; Fri, 19 Jul 2002 23:53:36 -0400
Received: from relay1.pair.com ([209.68.1.20]:1541 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S317340AbSGTDxg>;
	Fri, 19 Jul 2002 23:53:36 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D38E022.4005981E@kegel.com>
Date: Fri, 19 Jul 2002 20:59:30 -0700
From: dank@kegel.com
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > <http://www.opengroup.org/onlinepubs/007904975/functions/select.html>
> > says that 'select' may modify its timeout argument only "upon
> > successful completion".  However, the Linux kernel sometimes modifies
> > the timeout argument even when 'select' fails or is interrupted.
> 
> This is extremely useful behaviour. POSIX is broken here. 

I tried to make use of this behavior back in 2.2 days, I think,
and ran into trouble.  The time remaining wasn't quite right, I seem
to recall, making this nifty feature less useful.  I've since
given up on it.

> Fix it in the C library or somewhere it doesn't harm the clueful

Can you give an example of a clueful package that makes
use of this feature and would be harmed if select() suddenly
became posix-compliant?

- Dan
