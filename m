Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWGIQPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWGIQPP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 12:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWGIQPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 12:15:15 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:44911 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751291AbWGIQPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 12:15:13 -0400
Date: Sun, 09 Jul 2006 10:11:42 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Runnable threads on run queue
In-reply-to: <fa.CQngdtRN/1xSBi2RLvhjLxBm1bE@ifi.uio.no>
To: Ask List <askthelist@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <44B12ABE.4010303@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.CQngdtRN/1xSBi2RLvhjLxBm1bE@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ask List wrote:
> Have an issue maybe someone on this list can help with. 
> 
> At times of very high load the number of processes on the run queue drops to
>  0 then jumps really high and then drops to 0 and back and forth. It seems to
> last 10 seconds or so. If you look at this vmstat you can see an example of 
> what I mean. Now im not a linux kernel expert but i am thinking it has 
> something to do with the scheduling algorithm and locking of the run queue. 
> For this particular application I need all available threads to be processed as
> fast as possible. Is there a way for me to elimnate this behavior or at least
> minimize the window in which there are no threads on the run queue? Is there a
> sysctl parameter I can use?
> 
> Please help.

This seems like a userspace issue to me. There is no way the scheduler 
would let the system sit idle for 10 seconds with runnable processes. I 
think Rik van Riel's comment about sendmail reacting to increased load 
average may be related to what's going on here.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

