Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWCEV1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWCEV1X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 16:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWCEV1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 16:27:23 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:26187 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751805AbWCEV1W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 16:27:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sGSWHkcCoF+dRfFP8wML188waXfn/bRw8Ln+SNbON9ryDc9SmM/NAUUDaqrGJNAKv+qAtkbG//ttwHbgJoNENU7LbT8tk2ze5ximk0kMbRtRXSJYJUk35g6TSz5kCHPOWCxJv0YFx3IInlGJhdiqiokcNGLBqdmkxbR0CwQvleM=
Message-ID: <35fb2e590603051327u5dd4740eod7cc3b6afe583252@mail.gmail.com>
Date: Sun, 5 Mar 2006 21:27:21 +0000
From: "Jon Masters" <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "=?ISO-8859-1?Q?Ra=FAl_Baena?=" <raul_baena@ya.com>
Subject: Re: Doubt about scheduler
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <440AE3F3.3090404@ya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4407584A.60301@ya.com>
	 <35fb2e590603032233i7302162do553ba61674cc8e50@mail.gmail.com>
	 <440AE3F3.3090404@ya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/06, Raúl Baena <raul_baena@ya.com> wrote:

> Thank you very much Jon. But I think I haven´t explained very well.

No, you did. Perhaps I wasn't terse enough in my reply :-)

> I know that now the prio_array and runqueues structs aren´t accesible
> for modules, but in the 2.6.5 version they were. I would like to know
> the reason, why before they were accesible and now they don´t?

Because it's a /bad idea/ to screw around with these. That's why. I
was trying to say that nicely before - it's cleaner and safer if the
scheduler is the only thing playing there as it's the only thing with
a bona fide need.

I'm not trying to be offensive at all - by all means make your own
kernel, perhaps with an exported version of these structure or
introduce your own API for tinkering with them. But just don't
necessarily expect everyone else to jump at it :-)

Jon.
