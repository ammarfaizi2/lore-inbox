Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTLQXDV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 18:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTLQXDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 18:03:21 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:5261 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264601AbTLQXDT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 18:03:19 -0500
Date: Wed, 17 Dec 2003 15:02:48 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: jshankar <jshankar@CS.ColoState.EDU>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 file system
Message-ID: <20031217230248.GH1402@matchmail.com>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	jshankar <jshankar@CS.ColoState.EDU>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3FF129DA@webmail.colostate.edu> <Pine.LNX.4.53.0312171720020.32724@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0312171720020.32724@chaos>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 05:25:49PM -0500, Richard B. Johnson wrote:
> to the physical media. There are special file-systems (journaling)
> that guarantee that something, enough to recover the data, is
> written at periodic intervals.

Most journaling filesystems make guarantees on the filesystem meta-data, but
not on the data.  Some like ext3, and reiserfs (with suse's journaling
patch) can journal the data, or order things so that the data is written
before any pointers (ie meta-data) make it to the disk so it will be harder
to loose data.
