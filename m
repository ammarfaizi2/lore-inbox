Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbTFBQBF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTFBQBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:01:05 -0400
Received: from pop03.sprintmail.com ([207.217.120.173]:32462 "EHLO
	goose.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262548AbTFBQBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:01:03 -0400
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1054564236.4190.15.camel@iso-8590-lx.zeusinc.com>
References: <Pine.LNX.4.44.0306020937250.2970-100000@localhost.localdomain>
	 <1054564236.4190.15.camel@iso-8590-lx.zeusinc.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054567498.3545.18.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 11:24:59 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.4, required 10,
	AWL, EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 10:30, Tom Sightler wrote:
> I'm almost positive that wine doesn't consume that much CPU under 2.4,
> but I'm off to run some tests to prove or disprove that right now.

Well, I'm going to have to eat these words.  The problem with wine does
seem to show up with 2.4 as well, although not as bad, and seems
slightly harder to trigger.  That www.disney.com page does indeed show
the problem on both 2.4 and 2.5 kernels.  I'm not sure why it's worse
under 2.5 though, I still wonder if maybe it's because it's getting a
priority boost, it almost seems it should get a penalty for being a CPU
hog as Ingo pointed out.  I can easily fix this in userspace so maybe
this is a non-issue.  If so, I apologize for bringing it to the list.  

The only other case that is obviously worse under 2.5 than with 2.4 is
VMware 4 (interestingly, VMware 3.2 seems exactly the opposite) however,
I believe that this may indeed be related more to the HZ change than
scheduling.  I'm doing more testing on that now.

Later,
Tom




