Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVHDG7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVHDG7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVHDG7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:59:23 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:56740 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261882AbVHDG7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:59:22 -0400
Message-ID: <42F1BCB2.8030006@nortel.com>
Date: Thu, 04 Aug 2005 00:58:58 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question on memory map of process on i386
References: <7276.1123129359@kao2.melbourne.sgi.com>
In-Reply-To: <7276.1123129359@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

> The gate page is a section of code that is generated as part of the
> kernel build.  At run time, the gate page is mapped into all the user
> space processes.  There is also a virtual dynamic .so (vdso) file that
> is created by the kernel and picked up by the linker, the vdso maps the
> kernel entries in the gate page.  Run this command and look for "gate".

Okay, I suspected it might be something like this.

Why does find_vma() fail for that page though?  This confuses some code 
that I wrote.  Do I have to teach my stuff about get_gate_vma() and 
in_gate_area()?

Chris
