Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbWGINTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbWGINTy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 09:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWGINTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 09:19:54 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:42103 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030494AbWGINTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 09:19:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ArnhEmea4Qw1wLxNUSG1jl+OEa7ZDS6/Pps/JeSSziffNdiGoJySip7tr6+VkYd+ob0o4ovcjvvKjEcDt/KDiafJEx8YCHccPAKcyXQ/lH2MjFLEaCeTeb30pGfRvgNLLNsVWXrlLAosbiJi8Wta7YYUNqT3ouqF4KTrajlAjzc=
Message-ID: <6bffcb0e0607090619j39540482w46f9c17cd862e002@mail.gmail.com>
Date: Sun, 9 Jul 2006 15:19:52 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc1-mm1
Cc: linux-kernel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>
In-Reply-To: <20060709051030.a73f832c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <6bffcb0e0607090402m1f6c09c7hc9abc380bf36d460@mail.gmail.com>
	 <20060709051030.a73f832c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sun, 9 Jul 2006 13:02:48 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> > TP hangs on
> >
> > <<<test_output>>>
> > setrlimit01    1  PASS  :  RLIMIT_NOFILE functionality is correct
> > setrlimit01    0  WARN  :  caught signal 2, not SIGSEGV
> > <<<execution_status>>>
> > duration=1071 termination_type=driver_interrupt termination_id=1 corefile=no
> > cutime=0 cstime=1
> > <<<test_end>>>
>
> Yep, thanks.
>
>
> RLIMIT_FSIZE can cause generic_write_checks() to reduce `count'.  So we cannot
> assume that `count' is equal to the total length size of the incoming iovec.
>

Problem solved, thanks.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
