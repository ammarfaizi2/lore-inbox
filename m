Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265673AbUAIAdb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUAIAdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:33:31 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:26842 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S265673AbUAIAcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:32:53 -0500
Date: Fri, 9 Jan 2004 01:32:38 +0100
From: Roger Luethi <rl@hellgate.ch>
To: u1_amd64@dslr.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: time cat /proc/*/statm ?
Message-ID: <20040109003238.GA15258@k3.hellgate.ch>
Mail-Followup-To: u1_amd64@dslr.net, linux-kernel@vger.kernel.org
References: <179256560250.20040108135458@dslr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179256560250.20040108135458@dslr.net>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jan 2004 13:54:58 -0500, u1_amd64@dslr.net wrote:
> Is it reasonable for a 64bit dual cpu to take 5+ seconds of processing to
> cat /proc/*/statm when there is hardly more than 1gb of actual memory
> space used by processes (the rest being filesystem cache)?
> 
> This makes top or anything else that uses statm, unusable.

Why does top still read /proc/*/statm anyway? It's not as if top actually
ever used that information (the top I looked at at the time, that is). I
submitted a patch a few months ago to remove statm because it is a)
broken and b) redundant. The message containing detailed reasoning
should be in the linux-mm archives.

Roger
