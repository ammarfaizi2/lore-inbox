Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUGJSqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUGJSqy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266348AbUGJSqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:46:53 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:4776 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266345AbUGJSqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:46:39 -0400
Date: Sat, 10 Jul 2004 11:46:01 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: L A Walsh <lkml@tlinx.org>,
       Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040710184601.GB5014@taniwha.stupidest.org>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <40EEC9DC.8080501@tlinx.org> <20040709215955.GA24857@taniwha.stupidest.org> <200407102143.49838.jk-lkml@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407102143.49838.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 09:43:49PM +0300, Jan Knutar wrote:

> I've seen this on a partition with NO other activity, than me
> editing a .c file with emacs in a project consisting of about 4
> files in total, compiling and testingocasionally, editing again,
> etc... Then one day, powerloss, when power came back, the file was
> nothing but null. Atleast it had correct size and timestamp though,
> great comfort, that. :)


This is expected.  XFS does not journal data.  If you want that then
use ext3 or reiserfs.


   --cw
