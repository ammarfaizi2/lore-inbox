Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131410AbRCXAER>; Fri, 23 Mar 2001 19:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131524AbRCXAEH>; Fri, 23 Mar 2001 19:04:07 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:3411 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S131410AbRCXADw>;
	Fri, 23 Mar 2001 19:03:52 -0500
Message-ID: <20010324010306.A6702@win.tue.nl>
Date: Sat, 24 Mar 2001 01:03:06 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: "James A. Sutherland" <jas88@cam.ac.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010322124727.A5115@win.tue.nl> <Pine.LNX.4.30.0103231721480.4103-100000@dax.joh.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.30.0103231721480.4103-100000@dax.joh.cam.ac.uk>; from James A. Sutherland on Fri, Mar 23, 2001 at 05:26:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 05:26:22PM +0000, James A. Sutherland wrote:

> > Clearly, Linux cannot be reliable if any process can be killed
> > at any moment.
> 
> What on earth did you expect to happen when the process exceeded the
> machine's capabilities? Using more than all the resources fails. There
> isn't an alternative.

That is the wrong way to phrase these things.
Large processes usually do not have a definite set of needed resources.
They can use lots of memory for buffers and cache and hash and be a bit
faster, or use much less and be a bit slower.
Linux first promises a lot of memory, but then fails to deliver,
without returning any error to the program.

