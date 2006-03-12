Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWCLEyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWCLEyy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 23:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWCLEyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 23:54:54 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:13984 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751377AbWCLEyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 23:54:54 -0500
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
From: Lee Revell <rlrevell@joe-job.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <1142063500.7605.13.camel@homer>
References: <200603102054.20077.kernel@kolivas.org>
	 <200603111650.23727.kernel@kolivas.org> <1142056851.7819.54.camel@homer>
	 <200603111824.06274.kernel@kolivas.org>  <1142063500.7605.13.camel@homer>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 23:54:42 -0500
Message-Id: <1142139283.25358.68.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 08:51 +0100, Mike Galbraith wrote:
> There used to be a pages in flight 'restrictor plate' in there that
> would have probably helped this situation at least a little.  But in
> any case, it sounds like you'll have to find a way to submit the IO in
> itty bitty synchronous pieces. 

echo 64 > /sys/block/hd*/queue/max_sectors_kb

There is basically a straight linear relation between whatever you set
this to and the maximum scheduling latency you see.  It was developed to
solve the exact problem you are describing.

Lee

