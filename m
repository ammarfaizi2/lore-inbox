Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288261AbSAHTcc>; Tue, 8 Jan 2002 14:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288262AbSAHTcW>; Tue, 8 Jan 2002 14:32:22 -0500
Received: from 24-163-106-43.he2.cox.rr.com ([24.163.106.43]:6050 "EHLO
	asd.ppp0.com") by vger.kernel.org with ESMTP id <S288261AbSAHTcP>;
	Tue, 8 Jan 2002 14:32:15 -0500
Date: Tue, 8 Jan 2002 14:32:29 -0500
Subject: Re: Whizzy New Feature: Paged segmented memory
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
Cc: Jacques Gelinas <jack@solucorp.qc.ca>, linux-kernel@vger.kernel.org
To: jtv <jtv@xs4all.nl>
From: Anthony DeRobertis <asd@suespammers.org>
In-Reply-To: <20020108181121.A12696@xs4all.nl>
Message-Id: <74063840-046E-11D6-8467-00039355CFA6@suespammers.org>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.480)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday, January 8, 2002, at 12:11 PM, jtv wrote:

>
> And, of course, the same for all other software.  But for a 
> highly secure
> project, for instance, that might be worth it.

I'd imagine most things would just work. It's only going to be 
the things that make assumptions about memory layout that will 
break.

I picked X as an example because it cares quite a bit about 
memory layout, especially when mapping in framebuffers and 
whatnot.

>
> 68K has predecrement/postincrement addressing modes (I'm not sure that
> counts as "forcing" the stack to grow downwards);

The address stack on 68K grows downwards because JSR, BSR, etc. 
do the stack manipulation for you.

Sure, you _could_ use JMP and BRA and maintain your own linkage, 
but that'd take a large performance hit. Much larger than making 
the data stack grow upwards, I dare say.

>  PPC has a symmetrical
> load/store-with-update IIRC.

Right. I don't think it cares. Nice architecture ;-)

