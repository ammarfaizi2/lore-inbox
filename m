Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284916AbRL2ARx>; Fri, 28 Dec 2001 19:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284905AbRL2ARo>; Fri, 28 Dec 2001 19:17:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4625 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284182AbRL2ARd>; Fri, 28 Dec 2001 19:17:33 -0500
Message-ID: <3C2D0B86.1010705@zytor.com>
Date: Fri, 28 Dec 2001 16:17:10 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: zImage not supported for 2.2.20?
In-Reply-To: <UTC200112290001.AAA139460.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

>>Does anyone have the patch to look at ?
>>
> 
> See http://www.cck.uni-kl.de/misc/tecra710/toshiba-small.diff
> 
> Andries
> 

Okay, now we have a model number: Toshiba Tecra 710CDT; I think I can 
actually get my hands on one if need be (we have one floating around 
TMTA I believe.)

I'm fairly certain the code as it exists is good.  If not, I would 
rather like to add a WBINVD (which needs to be patched 
out/conditionalized on i386, sigh) in between the low write and high 
read in the A20 wait loop.

	-hpa

