Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVG2Vwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVG2Vwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVG2VuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:50:11 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:23969 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S262809AbVG2Vsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:48:42 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [linux-pm] [PATCH] swsusp: simpler calculation of number of pages in PBE list
Date: Fri, 29 Jul 2005 23:53:38 +0200
User-Agent: KMail/1.8.1
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
References: <42EA87A0.908@stud.feec.vutbr.cz> <200507292243.28276.rjw@sisk.pl> <42EA9C38.90905@stud.feec.vutbr.cz>
In-Reply-To: <42EA9C38.90905@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507292353.39282.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 29 of July 2005 23:14, Michal Schmidt wrote:
> Rafael J. Wysocki wrote:
> > On Friday, 29 of July 2005 21:46, Michal Schmidt wrote:
> > 
> >>The function calc_nr uses an iterative algorithm to calculate the number 
> >>of pages needed for the image and the pagedir. Exactly the same result 
> >>can be obtained with a one-line expression.
> > 
> > 
> > Could you please post the proof?
> > 
> > Rafael
> 
> OK, attached is a proof-by-brute-force program. It compares the results 
> of the original function and the simplified one.
> 
> This is its output:
> 
> $ ./calc_nr2
> checked 0 ...
> checked 100000000 ...
> checked 200000000 ...
> checked 300000000 ...
> checked 400000000 ...
> checked 500000000 ...
> checked 600000000 ...
> checked 700000000 ...
> checked 800000000 ...
> checked 900000000 ...
> checked 1000000000 ...
> checked 1100000000 ...
> checked 1200000000 ...
> checked 1300000000 ...
> checked 1400000000 ...
> checked 1500000000 ...
> checked 1600000000 ...
> checked 1700000000 ...
> checked 1800000000 ...
> checked 1900000000 ...
> checked 2000000000 ...
> checked 2100000000 ...
> First difference at 2130706433:  -2147483646 x -2147483647
> 
> It means that the two functions give the same results for sensible 
> values of the input argument.
> They results only differ when they overflow into negative values. At 
> this point both of the results are useless.

Thanks, fine. :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
