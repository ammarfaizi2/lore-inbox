Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbVA1XLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVA1XLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 18:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVA1XLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 18:11:15 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:5014 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262815AbVA1XLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 18:11:12 -0500
Message-ID: <41FAC689.4010203@comcast.net>
Date: Fri, 28 Jan 2005 18:11:05 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org,
       "Trever L. Adams" <tadams-lists@myrealbox.com>
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a  
 threading error
References: <217740000.1106412985@[10.10.2.4]>	<41F30E0A.9000100@osdl.org>	<1106482954.1256.2.camel@tux.rsn.bth.se>	<20050126132504.3295e07d@dxpl.pdx.osdl.net>	<41F97E07.2040709@comcast.net> <20050128093104.61a7a387@dxpl.pdx.osdl.net>
In-Reply-To: <20050128093104.61a7a387@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:

>Here is the strace output of the part that SEGV's, looks like a DRI issue??
>  
>
Yep.. If you haven't already, just change the permissions on 
/dev/dri/card0 to give access to your user id and it should be fine. 
(Reporter of this bug had to do the same in order to get it working)

Something in the kernel changes as far as DRI goes - Dont know what. And 
I know why I wasn't affected - NVIDIA driver which doesnt use 
/dev/dri/*. Though Trever seems to be having an entirely different 
problem - one oddity being the continuos -EINTRs that his OO.o gets on 
startup.

Trever - If your problem isn't solved yet - Can you run gdb 
/path/to/ooffice from commandline and then when it segfaults, post the 
backtrace?

Parag
