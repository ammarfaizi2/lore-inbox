Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTKDV2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 16:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTKDV2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 16:28:31 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:50408 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S262566AbTKDV2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 16:28:30 -0500
Date: Tue, 4 Nov 2003 16:28:13 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Paul Venezia <pvenezia@jpj.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
Message-ID: <20031104212813.GC30612@ti19.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Paul Venezia <pvenezia@jpj.net>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0311041227180.20373-100000@home.osdl.org> <1067980063.24247.23.camel@d8000>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067980063.24247.23.camel@d8000>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 04:07:43PM -0500, Paul Venezia wrote:
> Tests are running now. Updates as events warrant.

Well, I'm too lazy to wait for a long test, but with a mere
100MB file, on 1GHz P3:

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
NPTL          100M  7735  99 127068  98 63048  84  7890  98 +++++ +++ +++++ +++
LinuxThreads  100M 11000  99 127928  97 59075  84 11290  98 +++++ +++ +++++ +++

So something is amiss.

Regards,

	Bill Rugolsky
