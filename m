Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSGQPby>; Wed, 17 Jul 2002 11:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315213AbSGQPby>; Wed, 17 Jul 2002 11:31:54 -0400
Received: from smtp.intrex.net ([209.42.192.250]:34824 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S315210AbSGQPbx>;
	Wed, 17 Jul 2002 11:31:53 -0400
Date: Wed, 17 Jul 2002 11:41:10 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] -print argument to find (was [PATCH for 2.4] fix find to not stumble over BK)
Message-ID: <20020717114110.B1688@tricia.dyndns.org>
References: <20020716170821.A8462@work.bitmover.com> <1026870033.1688.116.camel@irongate.swansea.linux.org.uk> <20020717020535.GB1901@tapu.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020717020535.GB1901@tapu.f00f.org>; from cw@f00f.org on Tue, Jul 16, 2002 at 07:05:35PM -0700
X-Declude-Sender: jlnance@intrex.net [216.181.42.97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 07:05:35PM -0700, Chris Wedgwood wrote:
> On Wed, Jul 17, 2002 at 02:40:33AM +0100, Alan Cox wrote:
> 
>     The -print is not needed. See IEEE Std 1003.1-2001
> 
>     If no expression is present, -print shall be used as the
>     expression.
> 
> [...]
> 
> Interesting...
> 
> 
> That said, I do out of habit as Solaris did/does require print and so
> does some other commercial OS (I forget which now).

Oh, its even more interesting.  If the -print is not present find prints
out the name of the pruned directories.  If it is present it does not:

    vmware> find . -name tmpdir -prune -o -type d
    .
    ./tmpdir
    ./output
    vmware> find . -name tmpdir -prune -o -type d -print
    .
    ./output

Jim
