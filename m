Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTILPMI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbTILPMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:12:08 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:40345 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261746AbTILPME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:12:04 -0400
Message-ID: <3F61E1F9.6030409@nortelnetworks.com>
Date: Fri, 12 Sep 2003 11:10:49 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dan Behman <dbehman@ca.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading: easiest userland method?
References: <OFACE20891.664CABA8-ON85256D9F.004FBBDE@torolab.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Behman wrote:
> Hi,
> 
> I have a need to programmatically determine whether or not hyperthreading
> is enabled (and in use) for licensing reasons in my application.
> Currently, I know of two ways to do this:


> From scouring the archives and the net, it doesn't seem like there's any
> API that currently exists, but perhaps I've missed something.
> /proc/cpuinfo gathers its information from somewhere - is there a way in
> userland to bypass /proc/cpuinfo and directly get this data manually?

You could probably load a kernel module to check this stuff.

For 2.4, in arch/i386/kernel/setup.c, look for the code that checks for 
X86_FEATURE_HT.  You should be able to just copy that logic into a 
kernel module and export the result via /proc.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

