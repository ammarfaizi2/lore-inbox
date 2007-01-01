Return-Path: <linux-kernel-owner+w=401wt.eu-S932874AbXAACk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874AbXAACk3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 21:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932878AbXAACk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 21:40:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:48410 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874AbXAACk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 21:40:28 -0500
In-Reply-To: <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain>
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain> <20061231194501.GE3730@rhun.ibm.com> <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <66cc662565c489fa9e604073ced64889@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line macros.
Date: Mon, 1 Jan 2007 03:40:19 +0100
To: "Robert P. J. Day" <rpjday@mindspring.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In this case, the second form
>> should be used when the macro needs to return a value (and you can't
>> use an inline function for whatever reason), whereas the first form
>> should be used at all other times.
>
> that's a fair point, although it's certainly not the coding style
> that's in play now.  for example,
>
>   #define setcc(cc) ({ \
>     partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
>     partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); })

This _does_ return a value though, bad example.


Segher

