Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUGJTTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUGJTTz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 15:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUGJTTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 15:19:55 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:59368 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266349AbUGJTTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 15:19:54 -0400
Date: Sat, 10 Jul 2004 12:19:14 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: Jan Knutar <jk-lkml@sci.fi>, L A Walsh <lkml@tlinx.org>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040710191914.GA5471@taniwha.stupidest.org>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407102143.49838.jk-lkml@sci.fi> <20040710184601.GB5014@taniwha.stupidest.org> <200407101555.27278.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407101555.27278.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 03:55:26PM -0300, Norberto Bensa wrote:

> I think we all know that. The point, why the hell does it null
> files?

A decision was made somewhere this is better than showing potentially
bogus or confidential data, so on log-reply some parts of files may be
zeroed.  I can see arguments for an againts this and clearly for a lot
of people the zeroing is a real pain.

It would be nice for some people to prevent log-replay zeroing files
but then something would have to be able to determine whether or not
these blocks were newly allocated (and this might contain confidential
data and need to be zeroed) or previously part of the file in which
case we probably would like them left alone.

I don't know any of the code well enough to know how easy this is or
even if I'm telling the truth :) Hopefully someone who does can speak
up on this.


  --cw
