Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263041AbTCLFIk>; Wed, 12 Mar 2003 00:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbTCLFIk>; Wed, 12 Mar 2003 00:08:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62223 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263041AbTCLFIi>; Wed, 12 Mar 2003 00:08:38 -0500
Message-ID: <3E6EC34B.2000605@zytor.com>
Date: Tue, 11 Mar 2003 21:19:07 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] add Via Nehemiah ("xstore") rng support
References: <200303120427.UAA00323@cesium.transmeta.com> <3E6EC2AD.7000504@pobox.com>
In-Reply-To: <3E6EC2AD.7000504@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>>
>> Note that your "=m" (*addr) is never actually used here -- it doesn't
>> affect the instruction encoding, and it only shows up in a comment.
>> Since gcc will generate an instruction mode here, it will be highly
>> confused.
>>
>> I am assuming 0xC0 is a modr/m byte, in which case the most sane
>> interpretation of this instruction would be "xstore %eax"; %edi is
>> presumably implicit since you claim it can take a REP prefix...
> 
> 
> and yet strangely the asm code seems to be correct :)
> 

Right... I got confused by the comment (the one inside the asm) and the
fact that "addr" appeared twice.  I think it's a bad comment; it draws
attention to the wrong thing.

	-hpa


