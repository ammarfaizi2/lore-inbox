Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269773AbUJMSMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269773AbUJMSMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 14:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269774AbUJMSMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 14:12:46 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39072 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269773AbUJMSMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 14:12:45 -0400
Date: Wed, 13 Oct 2004 11:11:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Alexander Nyberg <alexn@dsv.su.se>
cc: George Anzinger <george@mvista.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, roland@redhat.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Periodic posix timer support broke between 2.6.9-rc1 and
 2.6.9-rc1-bk17
In-Reply-To: <1097690892.615.32.camel@boxen>
Message-ID: <Pine.LNX.4.58.0410131110520.9970@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
  <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com> 
 <4154F349.1090408@redhat.com>  <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
  <41550B77.1070604@redhat.com>  <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
  <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com> 
 <4159B920.3040802@redhat.com>  <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
  <415AF4C3.1040808@mvista.com>  <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
  <Pine.LNX.4.58.0410062150310.18565@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0410121315170.5785@schroedinger.engr.sgi.com>
 <1097690892.615.32.camel@boxen>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Me thinks someone somewhere is using some of the bits that we
> "accidently" pass via sa.sa_flags by not setting it to 0, the regular
> flags don't seem to show this behaviour, and I couldn't see any real
> checking of the passed value of sa.sa_flags.

Nope. It was my screwed up setting of the resolution of CLOCK_REALTIME and
CLOCK_MONOTONIC. Fix was submitted to Linus and Andrew.

