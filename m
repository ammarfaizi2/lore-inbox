Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292183AbSBBBuo>; Fri, 1 Feb 2002 20:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292184AbSBBBuc>; Fri, 1 Feb 2002 20:50:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46852 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292183AbSBBBuS>; Fri, 1 Feb 2002 20:50:18 -0500
Message-ID: <3C5B45CD.5060401@zytor.com>
Date: Fri, 01 Feb 2002 17:50:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Peter Monta <pmonta@pmonta.com>
CC: garzik@havoc.gtf.org, linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201202334.72F921C5@www.pmonta.com> <20020201153346.B2497@havoc.gtf.org> <20020201205605.ED5111C5@www.pmonta.com> <3C5B1CBB.6080802@zytor.com> <20020201232723.12F3E1C5@www.pmonta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Monta wrote:

>>The point with the tests that have been mentioned is to derive such a
>>conservative estimate, and to raise a red flag if the output suddenly
>>becomes predictable.
>>
> 
> Ah, I see; I was misled by the "truly random" remark, sorry.  So a reasonable
> sanity test for a block of audio samples might be a standard deviation
> greater than a few LSB; this will catch constant or close-to-constant
> output.
> 


However, those aren't the main failure modes you need to be concerned 
with.  Antenna effects may actually be your biggest problem -- picking 
up deterministic signals from other parts of the system.

However, I believe this is a solved problem.  It would definitely be 
interesting taking rngd and figuring out a way to drive it from /dev/dsp 
-- probably not too difficult a modification.

	-hpa



