Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319246AbSIKRkd>; Wed, 11 Sep 2002 13:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319247AbSIKRkd>; Wed, 11 Sep 2002 13:40:33 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:57593
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319246AbSIKRkc>; Wed, 11 Sep 2002 13:40:32 -0400
Subject: Re: 2.4.19 OOPS [Repost]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: lists@corewars.org
Cc: Andrea Arcangeli <andrea@suse.de>, riel@conectiva.com.br,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020911191614.A2078@corewars.org>
References: <20020903190726.A15065@corewars.org>
	<20020904201155.A17544@corewars.org>
	<20020904182223.GE1210@dualathlon.random>
	<20020905223233.A3893@corewars.org>  <20020911191614.A2078@corewars.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 11 Sep 2002 18:48:16 +0100
Message-Id: <1031766496.5832.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 18:16, lists@corewars.org wrote:
> Just in case this might shed some more light on the problem...
> I recompiled the kernel with frame pointers about a week ago, and I
> didn't face a single oops till today morning, when I recompiled the
> kernel without frame-pointers and I've been getting the same
> oopses all day.
> 

Are you using gcc 3.0.x or an early gcc 3.1.x. There are bugs in those
where they write below the stack pointer which means an IRQ will corrupt
stuff. Turning on frame pointers might well hide this

