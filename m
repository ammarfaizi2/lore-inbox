Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWFFWEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWFFWEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWFFWEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:04:12 -0400
Received: from main.gmane.org ([80.91.229.2]:6819 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751197AbWFFWEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:04:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Quick close of all the open files.
Date: Tue, 06 Jun 2006 23:03:38 +0100
Message-ID: <yw1xodx6gcw5.fsf@agrajag.inprovide.com>
References: <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com> <200606062156.k56LuWFD001871@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: agrajag.inprovide.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:pFTdadoJp5wxlPaIOXG3i9tNimw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> On Wed, 07 Jun 2006 03:15:43 +0530, vamsi krishna said:
>> Hello,
>> 
>> I found that the following code is closing all the open files by the
>> program, do you think its a bug in kernel code?
>> 
>> ------------
>> fp = tmpfile();
>> fp->_chain = stderr;
>> fpclose(fp);
>> fp = NULL;
>
> strace that, and see how many times close() gets called.  If it gets
> called once, it's a kernel bug.  If it gets called once for each open
> file, it's a userspace bug.

Actually, it's not a bug at all.

> For bonus points, how did you verify that all the open files were closed?
>
> (Hint - what does that fp->_chain = stderr *really* do? ;)

As it touches the innards of the FILE type, it invokes undefined
behavior.  Nothing that follows can be considered a bug.

-- 
Måns Rullgård
mru@inprovide.com

