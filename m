Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266230AbUBKWdC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUBKWdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:33:01 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:17 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266230AbUBKWbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:31:40 -0500
Message-ID: <402AAECC.1010606@techsource.com>
Date: Wed, 11 Feb 2004 17:38:04 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: printk and long long
References: <200402111604.49082.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0402111655170.17933-100000@gaia.cela.pl> <c0e0gr$mcv$1@terminus.zytor.com> <yw1xvfmdwe4s.fsf@kth.se> <402AA2CE.2060104@nortelnetworks.com>
In-Reply-To: <402AA2CE.2060104@nortelnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Friesen wrote:
> Måns Rullgård wrote:
> 
>> What is the proper way to deal with printing an int64_t when int64_t
>> can be either long or long long depending on machine?
> 
> 
> Print it as long long, and even if there is an arch where that is 128 
> bits it'll still work.


In that case you'll want to cast it to (long long) before you pass it so 
as to be sure that "%lld" and the parameter are the same size.  Right?

