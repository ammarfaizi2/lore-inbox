Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTIKO30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbTIKO3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:29:25 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:64158 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261245AbTIKO3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:29:21 -0400
Date: Thu, 11 Sep 2003 15:28:09 +0100
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       richard.brunner@amd.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030911142809.GB20434@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
	richard.brunner@amd.com, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <Pine.LNX.4.44.0309110650390.28410-100000@home.osdl.org> <1063289641.2967.3.camel@dhcp23.swansea.linux.org.uk> <20030911162421.419f4432.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911162421.419f4432.ak@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 04:24:21PM +0200, Andi Kleen wrote:
 > I considered that when writing the patch, but: is_prefetch is a single byte 
 > memory access for something already in cache. Checking for an Athlon
 > CPU needs two memory accesses in boot_cpu_data at least (checking vendor
 > and model) 

You only need to check it once when the path is first taken, and then
set a variable that makes you exit as soon as you enter it again.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
