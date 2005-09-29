Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVI2EJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVI2EJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 00:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVI2EJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 00:09:18 -0400
Received: from mail0.lsil.com ([147.145.40.20]:26246 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1750808AbVI2EJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 00:09:17 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57060CD1F1@exa-atlanta>
From: "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>
To: "'Ray Lee'" <ray-lk@madrabbit.org>
Cc: "Bhattacharjee, Satadal" <Satadal.Bhattacharjee@engenio.com>,
       linux-kernel@vger.kernel.org,
       "Patro, Sumant" <Sumant.Patro@engenio.com>,
       "Ram, Hari" <hari.ram@engenio.com>,
       "Mukker, Atul" <Atul.Mukker@engenio.com>
Subject: RE: Registering for multiple SIGIO within a process
Date: Thu, 29 Sep 2005 00:09:11 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Wed, 2005-09-28 at 20:44 -0400, Bagalkote, Sreenivas wrote:
>> >(Sheesh, what is it with people thinking signals are 
>something to be 
>> >used in any design after the 1970's?)
>> What's your recommendation for asynchronous notification from driver 
>> to an application?
>
>Pass back an fd to select() upon. Cuts out that nasty middle 
>step where app authors end up registering a signal handler 
>that merely write()s the signal number down a pipe into the 
>(nearly ubiquitous) select loop.
>
>Ray
>

select() is not asynchronous to the app (like a signal handler is).
