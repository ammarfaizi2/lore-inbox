Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290570AbSA3UcR>; Wed, 30 Jan 2002 15:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290572AbSA3UcI>; Wed, 30 Jan 2002 15:32:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43780 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290570AbSA3Uby>; Wed, 30 Jan 2002 15:31:54 -0500
Message-ID: <3C585824.50606@zytor.com>
Date: Wed, 30 Jan 2002 12:31:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Ville Herva <vherva@niksula.hut.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: master.kernel.org status
In-Reply-To: <3C57A9BF.60100@zytor.com> <20020130202648.GE341293@niksula.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:

> 
>>Whew...
>>
>>Thanks to a tip from Leonard Zubkoff I've successfully reconstructed the 
>>data on master.kernel.org. 
> 
> After the well-deserved sleep, would you (or Leonard) care to share the tip?
>


It's rather card-specific, but here goes:

a) On a DAC960PRL, use the "daccf" utility, not "ezsetup" which is what
the Mylex web page recommends (THIS ONE IS THE REASON FOR THE FAILURE IN
THE FIRST PLACE.)

b) After "ezsetup" screws over your configuration, you *may* be able to
recover it by running "daccf -o" and restoring the configuration EXACTLY
AS IT WAS ORIGINALLY SET UP.  DO NOT START A REBUILD OF THE ARRAY.

c) After (b), DO NOT WRITE TO THE ARRAY.  (Boot from a floppy or
SuperRescue CD, then try to access the drives readonly.)  Apparenly the
firmware won't actually write to the disks and start any kind of
reconstruction (which would be fatal to your data if you got step (b)
wrong) until any write operations happen to the disk set.

	-hpa


