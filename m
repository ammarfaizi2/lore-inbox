Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbUAZFGO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 00:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbUAZFGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 00:06:14 -0500
Received: from hive.scnr.net ([80.190.231.103]:51375 "HELO hive.scnr.net")
	by vger.kernel.org with SMTP id S265511AbUAZFGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 00:06:11 -0500
Date: Mon, 26 Jan 2004 06:05:43 +0100
From: Hans Spath <ml-lkml@hans-spath.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: data corrupton when recieving files > 1GB over network
Message-ID: <20040126050543.GA11649@hive>
Reply-To: Hans Spath <ml-lkml@hans-spath.de>
References: <5.1.0.14.2.20040111161640.014ad6c0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20040111161640.014ad6c0@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 05:36:32PM +0100, I wrote:
> When I transfer files to my linux 2.6.1 box their content changes
> (tested via md5 sums).
> [no problem with Knoppix 3.2 (Linux 2.4.21-xfs)] 

I've finally found the problem. It was a *hardware* problem.

The problem occured only with DMA activated for harddisks and the
Knoppix kernel doesn't do this by default.
(It was a bit strange, because it happend only when writing to disk
while having high network traffic, even after switching NIC and IDE
controler.)

I've exchanged the mainboard and now everything is working perfectly.

Sorry for wasting your time, folks.
