Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282829AbRLTJVY>; Thu, 20 Dec 2001 04:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282823AbRLTJVO>; Thu, 20 Dec 2001 04:21:14 -0500
Received: from jalon.able.es ([212.97.163.2]:54223 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S282815AbRLTJVC>;
	Thu, 20 Dec 2001 04:21:02 -0500
Date: Thu, 20 Dec 2001 10:22:38 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 3.0.2/kernel details (-O issue)
Message-ID: <20011220102238.A5957@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.10.10112192037490.3265-100000@luxik.cdi.cz> <1008792213.806.36.camel@phantasy> <20011220001006.GA18071@arthur.ubicom.tudelft.nl> <9vrmhd$mf9$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <9vrmhd$mf9$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Dec 20, 2001 at 04:39:25 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011220 H. Peter Anvin wrote:
>Followup to:  <20011220001006.GA18071@arthur.ubicom.tudelft.nl>
>By author:    Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
>In newsgroup: linux.dev.kernel
>> 
>> It doesn't change syntax, but anything lower than -O1 simply doesn't
>> inline functions with an "inline" attribute. The result is that the
>> inline functions in header files won't get inlined and the compiler
>> will complain about missing functions at link time (or module insert
>> time).
>> 
>> I'm actually surprised that 2.2 can be compiled with -O, AFAIK
>> linux-2.2 also has a lot of inline functions in headers. I know from
>> experience that -Os works for 2.4 kernels on ARM, I haven't tested it
>> with 2.2 or x86.
>> 
>
>-O is -O1.  If you turn on the optimizer at all you get inlining.
>

Problem is killing inlined functions. Current kernel relies in the
real version of the funtion staying there even all its uses have been
inlined. GCC's before 3 do not do what they are supposed to and do not
kill the real function. GCC3 kills it in certain cases and build
crashes. So kernel builds ok with old gcc's because they do not do
what they are supposed. Hence all the 'extern inline' mesh...
(plz, correct me if I'm wrong).

By

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.17-rc2-beo #2 SMP Wed Dec 19 22:24:29 CET 2001 i686
