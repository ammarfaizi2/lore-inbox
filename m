Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270712AbRIAO0h>; Sat, 1 Sep 2001 10:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270721AbRIAO00>; Sat, 1 Sep 2001 10:26:26 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:29547 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S270712AbRIAO0S>;
	Sat, 1 Sep 2001 10:26:18 -0400
Message-ID: <20010901162646.A22303@win.tue.nl>
Date: Sat, 1 Sep 2001 16:26:46 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Jens Gecius <jens@gecius.de>, linux-kernel@vger.kernel.org
Subject: Re: ide problem on 2.2.17?
In-Reply-To: <874rqnf5hy.fsf@maniac.gecius.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <874rqnf5hy.fsf@maniac.gecius.de>; from Jens Gecius on Sat, Sep 01, 2001 at 08:41:13AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2001 at 08:41:13AM -0400, Jens Gecius wrote:

> Sep  1 02:07:46 torriac kernel: dev 03:02 blksize=4096 blocknr=538976288 sector=16843008 size=4096 count=1
> Sep  1 02:07:46 torriac kernel: dev 03:02 blksize=4096 blocknr=1394618400 sector=-1727954688 size=4096 count=1
> Sep  1 02:07:46 torriac kernel: dev 03:02 blksize=4096 blocknr=1092645985 sector=151233288 size=4096 count=1
> Sep  1 02:07:46 torriac kernel: dev 03:02 blksize=4096 blocknr=824210032 sector=-1996254336 size=4096 count=1
> 
> What is going on?? I found something for older 2.2 kernels (broken ide
> driver), but 2.2.17?
> 
> Does this cause problems accessing certain files (because my apache
> doesn't find any htpasswd-files for limited access on certain pages)?

 538976288: "    "
1394618400: " 0 S"
1092645985: "at A"
 824210032: "pr 1"

Your buffer heads were overwritten with garbage (perhaps
some ls output) or point at data. Bad.
I have seen this before but forget what caused it.
Alan will remind us.
