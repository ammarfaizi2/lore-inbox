Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161381AbWJSKRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161381AbWJSKRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161383AbWJSKRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:17:23 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:20834 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161381AbWJSKRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:17:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hwh+8w3hKyq4/m/CoYIUBwux4Yzmbushmwl2RgoKBgk0JuNw0PUxztJHzO48ihTry8U+04GMbmqrRvToNflVhp3sxCg5NHejCDKfoNjUvNbHIDfkB8FYhpX6BZ0vz+URX+v76u8iVR9KHeTLeCUWgwkLlZUizPCw+MAR1R39P5c=  ;
Message-ID: <453750AA.1050803@yahoo.com.au>
Date: Thu, 19 Oct 2006 20:17:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       Paul Menage <menage@google.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Dinakar Guniguntala <dino@in.ibm.com>,
       Rohit Seth <rohitseth@google.com>, Robin Holt <holt@sgi.com>,
       dipankar@in.ibm.com, "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [RFC] cpuset: add interface to isolated cpus
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
In-Reply-To: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> From: Paul Jackson <pj@sgi.com>
> 
> Enable user code to isolate CPUs on a system from the domains that
> determine scheduler load balancing.
> 
> This is already doable using the boot parameter "isolcpus=".  The folks
> running realtime code on production systems, where some nodes are
> isolated for realtime, and some not, and where it is unacceptable
> to reboot to adjust this, need to be able to change which CPUs are
> isolated from the scheduler balancing code on the fly.
> 
> This is done by exposing the kernels cpu_isolated_map as a cpumask
> in the root cpuset directory, in a file called 'isolated_cpus',
> where it can be read and written by sufficiently privileged user code.

This should be done outside cpusets.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
