Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWCDGdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWCDGdx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 01:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWCDGdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 01:33:53 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:52979 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750933AbWCDGdw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 01:33:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P2qxzgQeLcNs3MlIGNO+QAF3lx9q345edz5Ie1Km/tFetAnYMfECMs/Sq1P+BzzQzFTbFBawXoNq/s0/KoqMcHPp1B8zkWEzMnenG6AYMydQZr4jnsXqduzBNY2TEEEfekQMJNd/xEebPnntwmDvZPF2qw7zyI98dJvsJEPF/Lo=
Message-ID: <35fb2e590603032233i7302162do553ba61674cc8e50@mail.gmail.com>
Date: Sat, 4 Mar 2006 06:33:51 +0000
From: "Jon Masters" <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "=?ISO-8859-1?Q?Ra=FAl_Baena?=" <raul_baena@ya.com>
Subject: Re: Doubt about scheduler
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4407584A.60301@ya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4407584A.60301@ya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/06, Raúl Baena <raul_baena@ya.com> wrote:

> Hello!!!, I´m a student of computer science and I´m doing my final
> degree job in linux. It is about "linux kernel modules" , I have to know
> some things of the scheduler. The runqueue struct, and so on. The
> problem is that in the last linux kernel version in the "sched.h" isn´t
> defined these structs (prio_array, runqueue...), and I cann´t access to
> runqueue or prio_array fields. I know that in the 2.6.5 kernel version
> these fields were accessible and now don´t, could you tell me what is
> the reason please?

Deliberately, these aren't available outside of the scheduler so that
they can't be played with. Much as things like the symbol table aren't
exported to modules, some things in the kernel aren't even available
to other parts of the core kernel :-)

>  I think that I´m going to do it (the module) in the 2.6.5 kernel
> version and will try to explain why, and for this I need your help.

If you really need to play with this stuff, then why not just make
your own kernel tree with this hacked up in the scheduler code itself?
If it's just for you, then that'll work fine. If you would explain
what it is that you need to do, then someone might be able to offer
you advice on the general direction to take - see also
http://www.kernelnewbies.org/

Jon.
