Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVASVZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVASVZB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVASVZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:25:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62664 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261904AbVASVY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:24:58 -0500
Date: Wed, 19 Jan 2005 16:24:14 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Bill Davidsen <davidsen@tmr.com>, Dan Hollis <goemon@anime.net>,
       Venkat Manakkal <venkat@rayservers.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       Paul Walker <paul@black-sun.demon.co.uk>,
       <linux-kernel@vger.kernel.org>, <linux-crypto@nl.linux.org>
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
In-Reply-To: <1106157459.19164.8.camel@ghanima>
Message-ID: <Xine.LNX.4.44.0501191623140.30540-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005, Fruhwirth Clemens wrote:

> I've rewritten some CBC code to fit the facilities I introduce in my LRW
> patch[1]. Here are the results for my P4@1.8GHZ:
> 
> loop-aes, CBC: ~30.5mb/s
> dm-crypt, CBC prior to my rewrite: ~23mb/s
> dm-crypt, CBC with my LRW patch: ~27mb/s
> dm-crypt, LRW with my LRW patch: ~27mb/s (slightly faster than CBC)
> 
> As you can see my LRW patches (actually it's the generic scatterwalker
> which is part of the LRW patch set) halves the gap to loop-aes. 

This looks promising.  I wonder if the generic scatterwalker solves the 
null encryption performance problem that was reported a little while back.


- James
-- 
James Morris
<jmorris@redhat.com>


