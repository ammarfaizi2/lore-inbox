Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270774AbTGVB3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 21:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270777AbTGVB3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 21:29:02 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:15592 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S270774AbTGVB3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 21:29:00 -0400
Date: Mon, 21 Jul 2003 21:43:45 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: hid: ctrl urb status -75?
Message-ID: <20030722014345.GA9226@bittwiddlers.com>
References: <20030722012137.GA7159@bittwiddlers.com>
	<20030721183338.44634e51.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030721183338.44634e51.rddunlap@osdl.org>
User-Agent: Mutt/1.5.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.75 (Ponder)
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1059270229.986b52@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: include/asm-generic/errno.h says that 75 is EOVERFLOW.
: Now look in Documentation/usb/error-codes.txt and it says that
: EOVERFLOW is used for:
: -EOVERFLOW (*)		The amount of data returned by the endpoint was
: 			greater than either the max packet size of the
: 			endpoint or the remaining buffer size.  "Babble".
: 
: The device returned too much data.
: See whichever host controller driver you are using for details.

Strange.  Thanks.  For some reason I was thinking those error codes returned
by the driver were more specific to it.  I see where the message is generated
and now just need to figure out what the deal is with it here.  It works fine
under at least two other OSes so I know the keyboard works.

-- 
  Matthew Harrell                          Do not meddle in the affairs of cats
  Bit Twiddlers, Inc.                       for they are subtle and will piss
  mharrell@bittwiddlers.com                 on your computer
