Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275939AbSIUUSt>; Sat, 21 Sep 2002 16:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275940AbSIUUSt>; Sat, 21 Sep 2002 16:18:49 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:37908 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S275939AbSIUUSt>;
	Sat, 21 Sep 2002 16:18:49 -0400
Date: Sat, 21 Sep 2002 22:23:53 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 won't run X?
Message-ID: <20020921202353.GA15661@win.tue.nl>
References: <20020921161702.GA709@iucha.net> <597384533.1032600316@[10.10.2.3]> <20020921185939.GA1771@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020921185939.GA1771@iucha.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 01:59:39PM -0500, Florin Iucha wrote:

> X is not locked up, as it eats all the CPU. And 2.5.36 works just fine.

I noticed that the pgrp-related behaviour of some programs changed.
Some programs hang, some programs loop. The hang occurs when they
are stopped by SIGTTOU. The infinite loop occurs when they catch SIGTTOU
(and the same signal is sent immediately again when they leave the
signal routine).
Have not yet investigated details.

