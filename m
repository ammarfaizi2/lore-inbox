Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbTDCSdD 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261526AbTDCSdD 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:33:03 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:11884 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261520AbTDCSc4 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 13:32:56 -0500
Date: Thu, 3 Apr 2003 13:44:18 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org, <linux390@de.ibm.com>
Subject: Re: gcc-3.2 breaks rmap on s390x
In-Reply-To: <20030403131054.B25676@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0304031339350.11467-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Pete Zaitcev wrote:

>  			cpu_relax();
> +			barrier();

Gah, now I look over the source I see that cpu_relax() is always
used together with barrier() ...

I guess the best long-term thing (2.5) would be to build a barrier
into cpu_relax(), but for 2.4-rmap I'll just add your patch.

