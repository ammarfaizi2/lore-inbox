Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbSKNVpQ>; Thu, 14 Nov 2002 16:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSKNVpQ>; Thu, 14 Nov 2002 16:45:16 -0500
Received: from tapu.f00f.org ([66.60.186.129]:18114 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S265276AbSKNVpP>;
	Thu, 14 Nov 2002 16:45:15 -0500
Date: Thu, 14 Nov 2002 13:52:09 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Paul Larson <plars@linuxtestproject.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: LTP - gettimeofday02 FAIL
Message-ID: <20021114215209.GA25778@tapu.f00f.org>
References: <1037139074.10626.37.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037139074.10626.37.camel@plars>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 04:11:14PM -0600, Paul Larson wrote:

    I have not been able to reproduce this on a single processor machine
    though.

    Basically, all the test does is:
    gettimeofday(&tv1, NULL);
    while(!done) {
    	gettimeofday(&tv2, NULL);
    	FAIL if tv2 < tv1
    	tv1 = tv2;
    }

    Any ideas on what could be causing this?


The TSC's aren't synchronized between CPUs.

This is becoming more and more of a problem and in-escapable on some
hardware so I'm starting to wonder if assuming the TSCs are even
roughly synchronized *anywhere* is a good idea.


   --cw
