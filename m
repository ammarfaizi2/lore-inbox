Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVL3USc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVL3USc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 15:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVL3USc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 15:18:32 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:63679 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932271AbVL3USb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 15:18:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KaZ7tsUX/cFUORswCvvkssD/yWy2RV+7nZB8L7akREdRaeWO+bZXgSwQhopNzlO2yfkAOHLf8sY/dM21g0xKhqz5hbaqFZCwstEROmxsMG7k4zZTvM9lDUzXZfYCxVe8gP0GXXNsQwg+lHUyxJjA7xKeD0NOeDtaGAw6L/W5PZU=
Message-ID: <986ed62e0512301218v30dd5d67m699bf7c29375a1fe@mail.gmail.com>
Date: Fri, 30 Dec 2005 12:18:29 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512302306.28667.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512302306.28667.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/05, Al Boldi <a1426z@gawab.com> wrote:
> Thanks a lot!
>
> > +3 - (NEW) paranoid overcommit The total address space commit
> > +      for the system is not permitted to exceed swap. The machine
> > +      will never kill a process accessing pages it has mapped
> > +      except due to a bug (ie report it!)
>
> This one isn't in 2.6, which is critical for a stable system.

I mentioned in my original post (maybe I wasn't clear enough) that
this is only in the documentation and not in the actual code (i.e. the
code has no advantage over 2.6 in this regard). This error comes from
the 2.4-ac/pac kernels from which this documentation originally comes.
Yes, I need to fix the documentation, I didn't get to do that yet.

I think you can get paranoid overcommit with either my patch or 2.6 by
setting /proc/sys/vm/overcommit_mode to 2 *and*
/proc/sys/vm/overcommit_ratio to 0, however.

--
-Barry K. Nathan <barryn@pobox.com>
