Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUBNPpw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 10:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUBNPpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 10:45:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15529 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262078AbUBNPk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 10:40:56 -0500
Date: Sat, 14 Feb 2004 15:40:55 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: chris.siebenmann@utoronto.ca, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
Message-ID: <20040214154055.GH8858@parcelfarce.linux.theplanet.co.uk>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <402E3066.1020802@laPoste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402E3066.1020802@laPoste.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 03:27:50PM +0100, Nicolas Mailhot wrote:
> There is no more justification to keep encoding undefined as there is to 
> keep time zone undefined. Last I've seen we're all pretty happy system 
> time actually means something on unix (unlike other systems where it can 
> be anything depending on the location where the initial installation was 
> performed).

"System time" is amount of time elapsed since the epoch.  Period.  What does
it have to any timezone?

The only place where timezone enters the picture is conversion of time to
year:month:day:hours:minutes:seconds and that's
	a) process-dependent and
	b) done outside of kernel

The same goes for file names.  Filename is a sequence of bytes, no more and
no less.  Anything beyond that belongs to applications.
