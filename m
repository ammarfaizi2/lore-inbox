Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSLTSPP>; Fri, 20 Dec 2002 13:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbSLTSPP>; Fri, 20 Dec 2002 13:15:15 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:36101
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S264659AbSLTSPO>; Fri, 20 Dec 2002 13:15:14 -0500
Subject: Re: [PATCH] Fix CPU bitmask truncation
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andreas Schwab <schwab@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, bjorn_helgaas@hp.com
In-Reply-To: <je7ke4yje3.fsf@sykes.suse.de>
References: <200212161213.29230.bjorn_helgaas@hp.com>
	 <20021220103028.GB9704@holomorphy.com>  <je7ke4yje3.fsf@sykes.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1040408597.1867.24.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Dec 2002 10:23:17 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-20 at 04:17, Andreas Schwab wrote:
> This is useless.  Assigning -1 to any unsigned type is garanteed to give
> you all bits one, and with two's complement this also holds for any signed
> type.

Only if the -1 is the same size as the unsigned type.  Otherwise it will
be 0-extended.

	J

