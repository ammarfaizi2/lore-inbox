Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUE1MWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUE1MWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUE1MTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:19:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35230 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262488AbUE1MSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 08:18:31 -0400
Date: Fri, 28 May 2004 14:18:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Gunther Persoons <gunther_persoons@spymac.com>
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.7-rc1-mm1] cant mount reiserfs using -o barrier=flush
Message-ID: <20040528121822.GH20657@suse.de>
References: <1085689455.7831.8.camel@localhost> <200405271928.33451.edt@aei.ca> <40B72886.3000507@spymac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B72886.3000507@spymac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28 2004, Gunther Persoons wrote:
> Hey,
> 
> <>Following warnings only come when i mount with the option 
> barrier=flush, i have never seen them before.
> hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hda: drive_cmd: error=0x04 { DriveStatusError }
> 
> Also this line clearly states that barrier doesn't work on my harddrive 
> although it's and IDE drive.
> hda: barrier support doesn't work.

error=0x04 is an aborted command, meaning it's not supported. So
ide-disk dumps that message to the log (barrier support doesn't work)
and turns it off. This is expected behaviour if your drive doesn't
support cache flushing.

-- 
Jens Axboe

