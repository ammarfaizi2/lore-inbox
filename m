Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbTANT6W>; Tue, 14 Jan 2003 14:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTANT6W>; Tue, 14 Jan 2003 14:58:22 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:34558 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S265130AbTANT6V>; Tue, 14 Jan 2003 14:58:21 -0500
Message-ID: <3E246DE5.7080302@nortelnetworks.com>
Date: Tue, 14 Jan 2003 15:07:01 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: timing an application
References: <Pine.LNX.4.51.0301142044400.6432@dns.toxicfilms.tv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak wrote:
> Hi,
> 
> being inspired by some book about optimizing c++ code i decided to do
> timing of functions i wrote. I am using gettimeofday to set
> two timeval structs and calculate the time between them.
> But the results depend heavily on the load, also i reckon that this
> is an innacurate timing.
> 
> Any ideas on timing a function, or a block of code? Maybe some kernel
> timers or something.

gettimeofday() is accurate.  However, your task may be interrupted by
other tasks, interrupts, etc.

Your best bet may be to do many iterations of the routine in question and then
do some statistical analysis of the results.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

