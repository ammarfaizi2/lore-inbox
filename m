Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285834AbRLTME3>; Thu, 20 Dec 2001 07:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286211AbRLTMES>; Thu, 20 Dec 2001 07:04:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40458 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285834AbRLTMEK>; Thu, 20 Dec 2001 07:04:10 -0500
Message-ID: <3C21D3A6.3030800@zytor.com>
Date: Thu, 20 Dec 2001 04:03:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: gcc 3.0.2/kernel details (-O issue)
In-Reply-To: <Pine.LNX.4.10.10112192037490.3265-100000@luxik.cdi.cz> <1008792213.806.36.camel@phantasy> <20011220001006.GA18071@arthur.ubicom.tudelft.nl> <9vrmhd$mf9$1@cesium.transmeta.com> <20011220102238.A5957@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

> 
> Problem is killing inlined functions. Current kernel relies in the
> real version of the funtion staying there even all its uses have been
> inlined. GCC's before 3 do not do what they are supposed to and do not
> kill the real function. GCC3 kills it in certain cases and build
> crashes. So kernel builds ok with old gcc's because they do not do
> what they are supposed. Hence all the 'extern inline' mesh...
> (plz, correct me if I'm wrong).
> 


You're wrong.  The thing is the kernel does NOT include any noninline 
functions, which breaks if you *don't* inline (like gcc doesn't if the 
optimizer isn't turned on...)

	-hpa


