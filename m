Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280970AbRKKGEQ>; Sun, 11 Nov 2001 01:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280976AbRKKGEH>; Sun, 11 Nov 2001 01:04:07 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:41741 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280970AbRKKGDw>;
	Sun, 11 Nov 2001 01:03:52 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Ranch <dranch@trinnet.net>
Cc: David Ranch <dranch@juniper.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.20 - Possible module symbol bug 
In-Reply-To: Your message of "Sat, 10 Nov 2001 20:38:58 -0800."
             <4.3.2.7.0.20011110194536.02cc6600@trinity3.trinnet.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 11 Nov 2001 17:03:38 +1100
Message-ID: <26985.1005458618@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2001 20:38:58 -0800, 
David Ranch <dranch@trinnet.net> wrote:
>I did start off with a clean config though I didn't do
>a "mrproper".  I re-tested on the MD7.0 box and
>"mrproper" solved my issue.  I haven't had to do this
>step since the old 2.0.2x days and I feel somewhat
>embarrassed by this.
>
>Thanks again for setting me strait though. I am
>curious for an explanation from the powers at be to
>why this hit me now though I've been compiling kernels
>without "mrproper" for years.  Am I just lucky?  ;-)

The implementation of module symbol versions is fundamentally broken.
The idea is good, to prevent incompatible modules being loaded into
your kernel and crashing it, but the implementation is built on several
assumptions that are not valid.  Total redesign coming up in kernel
2.5.  See the build 2.5 history package[1], expecially the html files.

Sometimes modversions work, more often then don't.

[1] http://sourceforge.net/project/showfiles.php?group_id=18813, under
    History.

