Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263349AbVFYG0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbVFYG0C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 02:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbVFYGXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 02:23:39 -0400
Received: from starsky.19inch.net ([80.1.73.116]:19673 "EHLO
	starsky.19inch.net") by vger.kernel.org with ESMTP id S263345AbVFYGSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 02:18:14 -0400
Date: Sat, 25 Jun 2005 07:17:33 +0100 (BST)
From: Paul Sladen <thinkpad@paul.sladen.org>
To: linux-thinkpad@linux-thinkpad.org
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>, abonilla@linuxwireless.org,
       "'Vojtech Pavlik'" <vojtech@suse.cz>, borislav@users.sourceforge.net,
       "'Pavel Machek'" <pavel@ucw.cz>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
In-Reply-To: <1119559367.20628.5.camel@mindpipe>
Message-ID: <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>
X-GPG-Key: DSA/E90CFA24
X-message-flag: Please use plain text when replying--not HTML.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005, Lee Revell wrote:
> Yup, it's just doing port IO.  Get a kernel debugger for windows like
> softice and this will be trivial to RE.
> READ_PORT_USHORT / WRITE_PORT_UCHAR / READ_PORT_UCHAR

There are 3 ports involved.  The 0xed "non-existant delay port" and a pair
of ports that are through the Super-I/O / IDE.  They are used in a
index+value setup similar to reading/writing the AT keyboard controller.

>From what I remember, my conclusion was that these instructions were the
ones to park the heads and then lock the IDE bus.  It's a couple of months
ago, but somewhere I have the simplified version of what it was doing...

	-Paul
-- 
It sometimes snows here.  Cambridge, GB


