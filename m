Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSGYQWv>; Thu, 25 Jul 2002 12:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSGYQWv>; Thu, 25 Jul 2002 12:22:51 -0400
Received: from tolkor.SGI.COM ([192.48.180.13]:35984 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S314811AbSGYQWu>;
	Thu, 25 Jul 2002 12:22:50 -0400
Date: Thu, 25 Jul 2002 11:25:21 -0500
From: Nathan Straz <nstraz@sgi.com>
To: John August <johna@babel.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 Fuji 1300 usb-storage problem
Message-ID: <20020725162521.GA10675@sgi.com>
Mail-Followup-To: John August <johna@babel.apana.org.au>,
	linux-kernel@vger.kernel.org
References: <20020725102955.A700@babel.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725102955.A700@babel.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 10:29:55AM +1000, John August wrote:
> Note that it does not get as far as identifying the partition table,
> and the Model is indicated as FinePix 1400Zoom, when its in fact a 1300,
> and previously it was "USB-DRIVEUNIT" as the model.

Maybe the 1300 doesn't have as broken a USB implementation as the 1400
does.  In linux/drivers/usb/storage/unusual_devs.h there is an entry for
the 1400.

UNUSUAL_DEV(  0x04cb, 0x0100, 0x0000, 0x2210,
                "Fujifilm",
                "FinePix 1400Zoom",
                US_SC_8070, US_PR_CBI, NULL, US_FL_FIX_INQUIRY),

The third and fourth numbers are the range of product identifiers to
consider unusual.  0x0000 - 0x2210 is probably a little broad.  Try
changing that to 0x2210 - 0x2210 and see if your 1300 works again.

-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
