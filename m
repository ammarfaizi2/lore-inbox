Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSGIA5C>; Mon, 8 Jul 2002 20:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSGIA5B>; Mon, 8 Jul 2002 20:57:01 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:57989 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316289AbSGIA5A>; Mon, 8 Jul 2002 20:57:00 -0400
Date: Mon, 8 Jul 2002 20:59:01 -0400
To: andrea@suse.de, jamagallon@able.es
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: pipe and af/unix latency differences between aa and jam on smp
Message-ID: <20020709005901.GA9616@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The -jam patchset is interesting because it starts out
with the entire -aa patchset and adds a few things.

Sometimes small differences in LMbench between -jam and -aa are 
just CPU bounces on SMP.  The difference for pipe and af/unix latency
only appears on SMP too, but it is very consistent.  (My k6/2
has small differences between -aa and -jam for pipe and af/unix
latency).

You will know better what could make the difference:

This is the averages:

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
kernel              Pipe    AF/Unix
-----------------  -------  -------
2.4.19-pre10-aa4    33.941   70.216
2.4.19-pre10-jam2    7.877   16.699


These are the individual runs:

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
OS                              Pipe   AF/Unix
-----------------------------  -------  ------
Linux 2.4.19-pre10-aa4         33.999   73.024 
Linux 2.4.19-pre10-aa4         35.829   73.261 
Linux 2.4.19-pre10-aa4         16.710   74.830 
Linux 2.4.19-pre10-aa4         37.221   66.354 
Linux 2.4.19-pre10-aa4         36.259   68.433 
Linux 2.4.19-pre10-aa4         36.429   68.215 
Linux 2.4.19-pre10-aa4         35.379   77.147 
Linux 2.4.19-pre10-aa4         29.300   73.641 
Linux 2.4.19-pre10-aa4         35.798   64.875 
Linux 2.4.19-pre10-aa4         35.691   75.433 
Linux 2.4.19-pre10-aa4         35.372   73.398 
Linux 2.4.19-pre10-aa4         33.516   69.183 
Linux 2.4.19-pre10-aa4         34.986   69.254 
Linux 2.4.19-pre10-aa4         33.743   69.893 
Linux 2.4.19-pre10-aa4         32.679   71.900 
Linux 2.4.19-pre10-aa4         34.131   71.812 
Linux 2.4.19-pre10-aa4         33.444   72.454 
Linux 2.4.19-pre10-aa4         36.531   71.956 
Linux 2.4.19-pre10-aa4         37.838   69.731 
Linux 2.4.19-pre10-aa4         34.359   71.522 
Linux 2.4.19-pre10-aa4         33.286   71.609 
Linux 2.4.19-pre10-aa4         32.361   43.533 
Linux 2.4.19-pre10-aa4         31.716   74.131 
Linux 2.4.19-pre10-aa4         35.218   72.001 
Linux 2.4.19-pre10-aa4         36.709   67.795 

Linux 2.4.19-pre10-jam2        7.9977   14.495 
Linux 2.4.19-pre10-jam2        7.8406   14.044 
Linux 2.4.19-pre10-jam2        7.7899   14.006 
Linux 2.4.19-pre10-jam2        7.8584   13.819 
Linux 2.4.19-pre10-jam2        7.8379   14.453 
Linux 2.4.19-pre10-jam2        7.8781   14.156 
Linux 2.4.19-pre10-jam2        7.8881   14.238 
Linux 2.4.19-pre10-jam2        7.9833   14.168 
Linux 2.4.19-pre10-jam2        7.7772   78.765 
Linux 2.4.19-pre10-jam2        8.0816   13.703 
Linux 2.4.19-pre10-jam2        7.8605   14.042 
Linux 2.4.19-pre10-jam2        7.7982   13.883 
Linux 2.4.19-pre10-jam2        7.6362   14.286 
Linux 2.4.19-pre10-jam2        7.7480   13.989 
Linux 2.4.19-pre10-jam2        7.9262   13.947 
Linux 2.4.19-pre10-jam2        8.0904   14.014 
Linux 2.4.19-pre10-jam2        7.8480   14.310 
Linux 2.4.19-pre10-jam2        7.7982   14.171 
Linux 2.4.19-pre10-jam2        7.9776   14.234 
Linux 2.4.19-pre10-jam2        7.7931   14.125 
Linux 2.4.19-pre10-jam2        7.8553   14.110 
Linux 2.4.19-pre10-jam2        7.7294   14.285 
Linux 2.4.19-pre10-jam2        8.3361   14.131 
Linux 2.4.19-pre10-jam2        7.7797   14.039 
Linux 2.4.19-pre10-jam2        7.8265   14.043 

For pipe and af/unix bandwidth, the difference appears to just be a
CPU bounce here and there.

jam patchsets are at:
http://giga.cps.unizar.es/~magallon/linux/

--
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

