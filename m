Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267122AbTAFUE0>; Mon, 6 Jan 2003 15:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267120AbTAFUE0>; Mon, 6 Jan 2003 15:04:26 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:29898 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S267119AbTAFUEZ>;
	Mon, 6 Jan 2003 15:04:25 -0500
Date: Mon, 6 Jan 2003 12:52:43 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andries.Brouwer@cwi.nl
Cc: zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mdharm-kernel@one-eyed-alien.net
Subject: Re: inquiry in scsi_scan.c
Message-ID: <20030106125243.A9710@beaverton.ibm.com>
References: <UTC200301052142.h05LgkH25404.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200301052142.h05LgkH25404.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Jan 05, 2003 at 10:42:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 10:42:46PM +0100, Andries.Brouwer@cwi.nl wrote:
> Zwane Mwaikambo writes:
> 
> > This looks related to something i also bumped into
> >
> > scsi scan: host 2 channel 0 id 0 lun 0 identifier too long
> 
> Sounds familiar. Please try the below (on 2.5.54).
> 
> Andries
> 

Instead of truncating the id, we need a new scsi_uid field allocated
to whatever size required. And, a descriptive string put in the name,
rather than the id, such as:

    scsi disk
    scsi processor
    scsi tape 

Even if the id is truncated, that information has to be available.

-- Patrick Mansfield
