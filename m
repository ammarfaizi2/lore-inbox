Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTFBPfk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTFBPfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:35:39 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:36233 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262464AbTFBPfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:35:39 -0400
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1054567498.3545.18.camel@iso-8590-lx.zeusinc.com>
References: <Pine.LNX.4.44.0306020937250.2970-100000@localhost.localdomain>
	 <1054564236.4190.15.camel@iso-8590-lx.zeusinc.com>
	 <1054567498.3545.18.camel@iso-8590-lx.zeusinc.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054568875.3545.34.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 11:47:56 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.4, required 10,
	AWL, EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 11:24, Tom Sightler wrote:
> I'm not sure why it's worse
> under 2.5 though, I still wonder if maybe it's because it's getting a
> priority boost, it almost seems it should get a penalty for being a CPU
> hog as Ingo pointed out.  I can easily fix this in userspace so maybe
> this is a non-issue.  If so, I apologize for bringing it to the list.  

In trying to figure out why this might be worse under 2.5 I took some
simple vmstat numbers under 2.4 and 2.5, this biggest difference is the
number of context switches.  Under 2.4, with the page loaded, but
otherwise idle, the system averages around 700/sec, and when I mouse
around the page I get 2000-3000/sec.

However, under 2.5, as I reported previously, I get 2000/sec all the
time, and 3000-4000 as I mouse around the page.

Would this be expected behavior?  Does 2.5 do something that would cause
more context switches that 2.4?  I have no idea if this would have any
impact at all, but it was the only difference I could observe in my
fairly simple testing of the two kernels.

Later,
Tom


