Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263233AbVFXSEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbVFXSEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 14:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbVFXSEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 14:04:13 -0400
Received: from sinclair.provo.novell.com ([137.65.81.169]:54891 "EHLO
	sinclair.provo.novell.com") by vger.kernel.org with ESMTP
	id S263233AbVFXSED convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 14:04:03 -0400
Message-Id: <s2bbf6b3.054@sinclair.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Fri, 24 Jun 2005 12:03:49 -0600
From: "Clyde Griffin" <CGRIFFIN@novell.com>
To: <kernel-stuff@comcast.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Novell Linux Kernel Debugger (NLKD)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> Parag Warudkar <kernel-stuff@comcast.net> 6/23/2005 3:14:26 PM >>>
>On Thursday 23 June 2005 18:54, Clyde Griffin wrote:
>> At this point the intent of this project is to gather comments and
>> suggestions on how to improve NLKD and make it possible for NLKD to be
>> included as a native (mainline) kernel debugger for Linux.  Novell
>> engineering will be actively involved in reviewing comments regarding NLKD
>> and submitting and receiving patches for the support of NLKD.
>
>Does / Will it support remote debugging over firewire ports? I think this 
>would  be a great opportunity to get rid of the serial port requirement for 
>debugging.

NLKD's architecture supports pluggable remote agents that talk directly
to hardware.  For remote debugging we currently we only have support 
for the serial port, but supporting other device types should be
fairly straightforward and doing so is on the todo list.

The main effort it is in writing the driver which must operate outside 
kernel context.  As we start to see support for additional hardware in remote 
debug agents we may spend the time to further abstract the remote 
debug protocol stack support away from the hardware driver.  

This architecture will be explained in our OLS paper.

In the mean time someone could simply take the RDA serial port code
and replace it with support for other hardware (NIC or whatever) and get 
the desired results.  

Again this sort of thing is on our todo list and we would really appreciate 
help from persons familiar with writing drivers for various device types 
to help jump start this.

Clyde

>
>Parag


