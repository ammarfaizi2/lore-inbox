Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265871AbSKFRzC>; Wed, 6 Nov 2002 12:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbSKFRzC>; Wed, 6 Nov 2002 12:55:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18963 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265871AbSKFRyN>; Wed, 6 Nov 2002 12:54:13 -0500
Message-ID: <3DC958BA.3030209@zytor.com>
Date: Wed, 06 Nov 2002 10:00:26 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
References: <Pine.LNX.4.32.0211061324110.19072-100000@gra-vd1.iram.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:
> 
> I basically agree but I suspect that filesystem writers will not be very
> happy if you want to use 16 bytes for each timestamp, especially when 8 of
> the bytes (the 32 high order bits from the second count and the TAI-UT
> offset) do not change very often. (besides that tv_nsec is defined as a
> long, i.e.  64 bit on 64 bit machines and _signed_ , stupid if you ask me
> but I digress).
> 

The filesystem writers can compact things as they see fit.  I'm mostly 
talking about the stat(2) format.

	-hpa

