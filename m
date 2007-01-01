Return-Path: <linux-kernel-owner+w=401wt.eu-S932861AbXAACmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbXAACmt (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 21:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932886AbXAACmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 21:42:49 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:53318 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S932878AbXAACms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 21:42:48 -0500
Message-ID: <367619213.19897@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 1 Jan 2007 10:40:29 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Hua Zhong <hzhong@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu, johnstul@us.ibm.com
Subject: Re: [BUG 2.6.20-rc2-mm1] init segfaults when CONFIG_PROFILE_LIKELY=y
Message-ID: <20070101024029.GA6249@mail.ustc.edu.cn>
Mail-Followup-To: Daniel Walker <dwalker@mvista.com>,
	Hua Zhong <hzhong@gmail.com>, Andrew Morton <akpm@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu,
	johnstul@us.ibm.com
References: <20061231150422.GA5285@mail.ustc.edu.cn> <1167594309.14081.79.camel@imap.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167594309.14081.79.camel@imap.mvista.com>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 11:45:09AM -0800, Daniel Walker wrote:
> On Sun, 2006-12-31 at 23:04 +0800, Fengguang Wu wrote:
> > Hi,
> > 
> > The following messages keeps popping up when CONFIG_PROFILE_LIKELY=y:
> > 
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > 
> 
> 
> Does this seem like an appropriate solution? This just reconstitutes
> Ingo's patch by removing the unlikely calls that got added recently. 
> 
> Maybe a comment into vsyscall.c that says to stay away from all macro's
> and possible debug code that could be added might be helpful ?
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Thanks, it worked!

