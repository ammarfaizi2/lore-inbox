Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUBMDDs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 22:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266693AbUBMDDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 22:03:48 -0500
Received: from mail.shareable.org ([81.29.64.88]:24450 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266689AbUBMDDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 22:03:47 -0500
Date: Fri, 13 Feb 2004 03:03:46 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040213030346.GF25499@mail.shareable.org>
References: <1076604650.31270.20.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076604650.31270.20.camel@ulysse.olympe.o2t>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Mailhot wrote:
> But that's not a reason not to fix the core problem - I don't want to
> spent hours fixing filenames next time someone comes up with a new
> encoding. Please put valid encoding info somewhere or declare filenames
> are utf-8 od utf-16 only - changing user locale should not corrupt old
> data.

If you attach encoding to names for a whole filesystem, you will get
really unpleasant bugs including security holes because some names
won't be writable, so the fs will either return error codes when those
names are used, or silently alter the names.

-- Jamie

