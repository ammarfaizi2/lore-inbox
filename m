Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVCHFFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVCHFFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVCHFFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:05:23 -0500
Received: from manson.clss.net ([65.211.158.2]:13960 "HELO manson.clss.net")
	by vger.kernel.org with SMTP id S261366AbVCHFFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:05:18 -0500
Message-ID: <20050308050518.6822.qmail@manson.clss.net>
From: "Alan Curry" <pacman-kernel@manson.clss.net>
Subject: Re: setserial is lieing to us, how to fix?
To: gene.heskett@verizon.net
Date: Tue, 8 Mar 2005 00:05:17 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200503072341.21752.gene.heskett@verizon.net> from "Gene Heskett" at Mar 07, 2005 11:41:21 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett writes the following:
>
>I'm on the horn with another linux user, and we have a question re the 
>setserial command.  Its reporting the base baud rate, but not the 
>actual.  We need to know the actual settings in use at the moment for 
>a serial port. How can we discover this?

stty speed -F /dev/ttyXY

The setserial spd_* options can affect speed but they are obsolete so you
shouldn't be using them. If stty says 38400 then the setserial spd_* is in
effect. If spd_normal, then 38400 means 38400. If spd_hi, then 38400 means
57600. If spd_vhi, then 38400 means 115200. If spd_shi, then 38400 means
230400. If spd_warp, then 38400 means 460800. Then there's spd_cust, which is
more weird.
