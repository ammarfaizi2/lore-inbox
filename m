Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbUEBAp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUEBAp0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 20:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUEBAp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 20:45:26 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:17104 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262850AbUEBApY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 20:45:24 -0400
Date: Sat, 1 May 2004 17:45:18 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: koke@amedias.org, linux-kernel@vger.kernel.org,
       Andries Brouwer <aeb@cwi.nl>, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040502004518.GA25445@taniwha.stupidest.org>
References: <20040430195351.GA1837@amedias.org> <20040501214617.GA6446@taniwha.stupidest.org> <20040501232448.GA4707@vana.vc.cvut.cz> <20040501234444.GA24120@taniwha.stupidest.org> <20040502003650.GB4707@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040502003650.GB4707@vana.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 02:36:50AM +0200, Petr Vandrovec wrote:

> Though it would be nice to be able to strace init too...

it has potential problems with what signals can be sent to pid 1 are
restricted

> It is strange. After logout it always comes up after 10 seconds
> delay in first agetty run expires.

that's usually but now always the case for me ... based on feedback
it's not always the case of others either

> Do not you start some multithreaded daemons from shell which gets
> later 'stuck'?

no

> Maybe that controlling terminal handling is not 100% yet. Do not
> some daemons "randomly" disappear since you use vhangup in agetty?

no

also, login uses vhangup too --- and has done for some time, so i
don't expect that this will change much at all

> AFAIK controlling terminal is not available through /proc :-(

i'm not sure it would be useful if it was, i guess maybe some of of
O_EXCL open hack might work to say we want to open the tty and fail if
anyone else has it open though

al?


  --cw

