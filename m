Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932732AbVHPV2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbVHPV2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVHPV2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:28:04 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:12124 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932731AbVHPV2B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:28:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hx4OEIXG4a4OAVbYWol5Nf7U0HhQ3IvXISry9y0ZWAH8QJYbOhbhc/WNcbNc3I5hytzYQA87qIbuaiV3U6KCBIuNayPPYTGgn6bKPZp6riVXX7+RA+ofitkpkcCK9iDD6635rw0bUGuGoFwTQ91HLSbJND0NZ7HsYTgbdlBxYVU=
Message-ID: <3faf0568050816142715f14c2c@mail.gmail.com>
Date: Wed, 17 Aug 2005 02:57:54 +0530
From: vamsi krishna <vamsi.krishnak@gmail.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: Multiple virtual address mapping for the same code on IA-64 linux kernel.
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F04294461@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <B8E391BBE9FE384DAA4C5C003888BE6F04294461@scsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Really thankful for your inputs!

> Itanium instruction set is not as compact as some other architectures,
> so the same program will typically require more bytes of code.

I stopped the program on both amd64 machine and ia64 machine and
grepped the values from /proc/<>/status and found the following.

<----Linux IPF----------->
VmSize:   126304 kB
VmLck:         0 kB
VmRSS:      6352 kB
VmData:    19696 kB
VmStk:        16 kB
VmExe:     97760 kB
VmLib:      3152 kB
<------------------------>

<------AMD64------------->
VmSize:   100432 kB
VmLck:         0 kB
VmRSS:      2828 kB
VmData:    24428 kB
VmStk:       264 kB
VmExe:     62848 kB
VmLib:      3048 kB
<----------------------->

Seems like most of core size(VmSize) on ipf (126MB) is coming from the
code size(VmExe) i.e 97MB. While the code size is just 62MB on amd64.

Looks like IA-64 wastes a lot of VM due to big instruction sizes, so
big instruction sizes will improve performance ? compared small
instruction sizes? , but fetching big instructions surely takes time
compared to small, this may be the reason why amd64 is the fasttest
64-bit process ?

Thanks a lot!
Vamsi
