Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWDXEm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWDXEm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 00:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWDXEm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 00:42:28 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:63642 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751507AbWDXEm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 00:42:28 -0400
Date: Sun, 23 Apr 2006 22:42:10 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux 2.6.17-rc2
In-reply-to: <64wre-2cg-35@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: s0348365@sms.ed.ac.uk
Message-id: <444C5722.6080605@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <63bym-4wt-3@gated-at.bofh.it> <64eE4-1gP-15@gated-at.bofh.it>
 <64eX5-1RE-13@gated-at.bofh.it> <64wre-2cg-35@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Saturday 22 April 2006 02:07, Andi Kleen wrote:
> [snip]
>> They probably forget to set PROT_EXEC in either mprotect or mmap somewhere.
>> You can check in /proc/*/maps which mapping contains the address it is
>> faulting on and then try to find where it is allocated or mprotect'ed.
> 
> Turned out this was exactly what the problem was. Wine attempts to match 
> Windows as far as read/write/execute mappings go, and war3.exe tried to 
> execute memory in a section with "MEM_EXECUTE" not set.
> 
> I'm surprised the program works on Windows with DEP/NX enabled, but apparently 
> it does.

Are you sure that it does? NX is not enabled by default on XP except on 
Windows system processes, even on CPUs supporting hardware NX, so it 
might well have failed with it turned on (especially since the problem 
seemed to show up after some no-CD crack was applied).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

