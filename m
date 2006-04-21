Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWDUESr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWDUESr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWDUESr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:18:47 -0400
Received: from pproxy.gmail.com ([64.233.166.178]:43178 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932230AbWDUESq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:18:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ionP/flemOWUh+QdSIJ4XVQ5Ka+ryY4Zi47iy/97lkjWbHNgSQOQW/oSuaIY8fiq642cIw4p90kuMrENrXP+dwa9XKX1tk9ifvC0+qThEyTrnnCkhweGNwZhSoTbhPkw20qDUVlnPfiVsT4Dnkepk2BcZZPFOZrhvrtdT3qS5S8=
Message-ID: <bda6d13a0604202118t51709a70g1f2402efb8ecbfe@mail.gmail.com>
Date: Thu, 20 Apr 2006 21:18:46 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rename "swapper" to "idle"
In-Reply-To: <E1FWjcX-0007Hj-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4448161D.9010109@gmail.com> <E1FWjcX-0007Hj-00@calista.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/06, Bernd Eckenfels <be-news06@lina.inka.de> wrote:
> Hua Zhong <hzhong@gmail.com> wrote:
> > This patch renames the "swapper" process (pid 0) to a more appropriate name "idle". The name "swapper" is not obviously meaningful and confuses a lot of people (e.g., when seen in oops report).
> > Patch not tested, but I guess it works. :-)

As we saw in "Which process is associated with process ID 0 (swapper)",
pid 0 can actually do things, such as resend TCP packets. Methinks idle
isn't the best name either.

>
> on win the system idle process shows up in taskmanager so you can see its
> cpu usage and ctx switches scheduled from it. We could avoid the skipping in
> /proc, also?
>
> Gruss
> Bernd
Please, no!

I already have to explain this mess about Windows. We shouldn't be implementing
Microsoft's flaws. Why waist the a line of screen for top?
