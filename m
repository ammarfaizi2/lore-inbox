Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbTHVFTm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 01:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbTHVFTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 01:19:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:28074 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263030AbTHVFTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 01:19:40 -0400
Date: Thu, 21 Aug 2003 22:19:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yaoping Ruan <yruan@cs.princeton.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel hangs up running web server
Message-Id: <20030821221949.2119e66c.akpm@osdl.org>
In-Reply-To: <3F459F02.B11234CF@cs.princeton.edu>
References: <3F3D672D.1AF660B6@cs.princeton.edu>
	<20030815164334.1e37b5b8.akpm@osdl.org>
	<3F459F02.B11234CF@cs.princeton.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaoping Ruan <yruan@cs.princeton.edu> wrote:
>
> Thus I've made both the server (Flash) and the workload generator (Flexiclient)
>  available at:
>  www.cs.princeton.edu/~yruan/flash
>   and would appreciate if any of the developers could try them out. To run the test
> 
>  1. generate fileset at server side by copying over fileset and
>     ./fileset -s zipfset -n #DIRS
>  2. compile Flash (may change options in config.h) and run
>     ./flash -user YOUR_ACCOUNT
>  3. run client as:
>     ./zipfgen -s spec -n #DIRS | ./batcher 5 | ./flexiclient -host HOST -time
>  SECONDS -active 1000
>  (it's a rarely happened bug, better to run more than 1800 seconds, with 1000
>  connections)

How does one tell the server how to locate its fileset?


I get this.  What does it mean?

vmm:/home/akpm/flash/flexi-curr> ./zipfgen -s spec -n 100 | ./batcher 5 | ./flexiclient -host localhost -time 2000 -active 1000
-host localhost : name of machine/interface running server
-port 31415 : listen port # on server
-active 1000 : number of simultaneous outstanding requests
-maxconns 0 : max idle and active connections
-persist groups : enable persistent connections (off,groups,force)
-hash 0 : print hash mark for each completed request
-time 2000 : # seconds to run test
-sync 0 : synchronize clients on different machines using clientmaster
-output  : sends incoming data to this file name
-printint 20 : specifies seconds to print real summary every
-reqrate 0 : if set, max burst request rate
-rcvwin 48 : if set, new size of receive window in KB
-exhdrs  : if set, extra headers for each request
-xml 0 : if set, produce output in XML format
-statfile stdout : sends statistics to this file
-doskip 0 : if set, skips trace entries to avoid batching
-trace 0 : same as -doskip
-persec 1 : print statistics at per second level
file flexiclient.c, line 796, not being held
