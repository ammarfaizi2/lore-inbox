Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVBZWwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVBZWwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 17:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVBZWwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 17:52:19 -0500
Received: from hera.cwi.nl ([192.16.191.8]:63939 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261289AbVBZWwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 17:52:13 -0500
Date: Sat, 26 Feb 2005 23:52:03 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
Message-ID: <20050226225203.GA25217@apps.cwi.nl>
References: <20050226213459.GA21137@apps.cwi.nl> <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de> <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 02:28:45PM -0800, Linus Torvalds wrote:

> Would it not make more sense to just sanity-check the size itself, and
> throw it out if the partition size (plus start) is bigger than the disk
> size?

I don't mind.

> There might well be people use use partition type 0, just because they
> just never _set_ the partition type.. I don't think Linux has ever cared
> about any type except for the "extended partition" type, so checking for 
> zero doesn't seem very safe..

The default fdisk will assign type 83 to a newly created partition.
One has to change it by hand to 0. So, I do not think testing against 0
is so bad. A heuristic, You give another heuristic. Probably there will
be a point in time where we need both.

(About type 0: DOS has used type 0 as definition of unused. It is not
bad if Linux uses DOS-conventions for a DOS-type partition table.)

Andries
