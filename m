Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbUAFW0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUAFW0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:26:05 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:25069 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264591AbUAFW0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:26:02 -0500
Date: Tue, 6 Jan 2004 14:25:25 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to sector_t being unsigned, advice requested
Message-ID: <20040106222525.GF1882@matchmail.com>
Mail-Followup-To: Oleg Drokin <green@linuxhacker.ru>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk> <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk> <20040106174650.GD1882@matchmail.com> <200401062135.i06LZAOY005429@car.linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401062135.i06LZAOY005429@car.linuxhacker.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 11:35:10PM +0200, Oleg Drokin wrote:
> Hello!
> 
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> MF> Did you check the locking after this is removed?
> 
> Locking should be fine.
> As I remember, we take this lock near reiserfs_get_block() entrance,
> and then drop it on exit.
> 

Ok, I just wondered if the sector_t merge overlooked this part, maybe it
also changed the locking in this area because of that.

> MF> Maybe after the sector_t merges, this code covered a case that is left open
> MF> now...
> 
> This code was never executing anyway.

Right.

Thanks,

Mike
