Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWAIMb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWAIMb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 07:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWAIMb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 07:31:57 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:60311 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751244AbWAIMb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 07:31:56 -0500
Date: Mon, 9 Jan 2006 13:31:52 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       git@vger.kernel.org
Subject: Re: git pull on Linux/ACPI release tree
In-Reply-To: <46a038f90601090211j33479764q13c74df60033a061@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0601091320420.2503@wbgn013.biozentrum.uni-wuerzburg.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A136FE@hdsmsx401.amr.corp.intel.com>
 <46a038f90601090211j33479764q13c74df60033a061@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 9 Jan 2006, Martin Langhoff wrote:

> In a sense we are still exploring possible/desirable workflows and what 
> the missing pieces are. And yes, some thing don't quite make sense from 
> the outside, perhaps because they just don't or because we arent' 
> explaining them very well.

Maybe what is needed here is this:

T1 - T2 .. Tn .. Tp
  \         \      \
   \         M1     M2
    \       /      /
     B1 .. Bm .. Bo

where T1..Tp are the upstream commits, B1..Bo are the local commits, and
M1.. are the test merges just to make sure nothing breaks?

As long as the Mx commits resolve automatically, no need for an explicit 
merge in the Bx commits, since a pull from B into T will just recreate an 
Mx as next commit in T.

Kind of "throw away merge".

Ciao,
Dscho
