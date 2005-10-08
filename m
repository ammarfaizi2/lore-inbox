Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVJHO0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVJHO0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 10:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVJHO0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 10:26:16 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:6032 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932091AbVJHO0Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 10:26:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b3CKzQpdiUPNjrIpQ2d+Eko4emgCG+lfwJxF4ePvITx+CPEKjkbipPdoAc7j8Y2uVrRFyUvNq0DQyrxpqaXvZrPBaU/bB46JhmfgQnCC285jPdSpGmNZEhOqAp22HTlTD+trBFU4ZMEwsCHPzTdWotz5ur8fTVP3kfDGTbdnulE=
Message-ID: <62b0912f0510080726ge2436e9ra6d7e8d17d1001ee@mail.gmail.com>
Date: Sat, 8 Oct 2005 14:26:14 +0000
From: Molle Bestefich <molle.bestefich@gmail.com>
To: andrew@walrond.org
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
Cc: htejun@gmail.com, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <43477836.6020107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510071111.46788.andrew@walrond.org>
	 <43477836.6020107@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:
> I need to deploy some very resilient servers with hot swapable drives.
[snip]
> Before I place an order, I need to know whether sata II hot swapping is up to
> scratch in the linux kernel, and whether it works nicely with linux software
> raid (which I already use/am familiar with).
>
> Any knowledge greatfully accepted :)

IDE hotswap has never worked (OOTB at least) in Linux, and based on my
experience it never will.  Seems the IDE folks doesn't care a bit
about it.  (No offence meant.  Just keeping it real.)

So if you really need this, here's the opportunity to make a whole lot
of people happy by implementing it yourself.  You'll probably need a
lot of time on your hands - there's a very real chance that the IDE
maintainers are too busy or whatever to answer any newbie questions
you might have about how to attack the IDE layer.


Tejun Heo wrote:
> If you're looking for stability/resilience for production machine,
> IMHO libata isn't still quite ready.

I disagree...
I've used it for TBs of data without any problems.

OTOH, with the regular ATA stuff I've experienced loads of IRQ
problems, crashes and hangups.
