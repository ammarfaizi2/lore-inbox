Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbTBQOQi>; Mon, 17 Feb 2003 09:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbTBQOOR>; Mon, 17 Feb 2003 09:14:17 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:18412 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S267215AbTBQONQ>; Mon, 17 Feb 2003 09:13:16 -0500
Date: Mon, 17 Feb 2003 15:23:00 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
In-Reply-To: <20030217141550.GM1073@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.33.0302171517280.16152-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Matti Aarnio wrote:

> This will store constants into  jiffies_msb_flips:
> ("1" for DEBUG_JIFFIESWRAP, "0" otherwise.)
> Wouldn't zero be what will always be needed ?

No - this is exactly what is intended. Note that jiffies_msb_flips counts
flips of the MSB of jiffies, i.e., it's LSB should always be equal to the
MSB of jiffies.
We use it as a measure of whether jiffies_msb_flips is still up to date -
when the msb of jiffies flip, we have 2^31/HZ seconds to detect that
in the timer routine.

Tim

