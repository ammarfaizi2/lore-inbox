Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWFUBpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWFUBpe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWFUBpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:45:34 -0400
Received: from thunk.org ([69.25.196.29]:51909 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750742AbWFUBpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:45:32 -0400
Date: Tue, 20 Jun 2006 21:45:37 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 2/8] inode-diet: Move i_pipe into a union
Message-ID: <20060621014537.GC5663@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153108.720582000@candygram.thunk.org> <Pine.LNX.4.61.0606191918310.23792@yvahk01.tjqt.qr> <20060619190610.GH15216@thunk.org> <20060620092351.E10897@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620092351.E10897@openss7.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 09:23:51AM -0600, Brian F. G. Bidulock wrote:
> 
> It's used for implementing STREAMS-based FIFOs.  Which is a proper use
> of i_pipe (which is for FIFOs).  Pipes (both mainline and STREAMS-based
> pipes) can use i_private instead of i_pipe.

It's is an abuse of i_pipe.  You are using something which is supposed
to hold a struct pipe_info, and storing the head of the STREAM stack,
which is some other type.  

In any case, when you state authoratively what "can" and "can not" be
combined, please specify when your justification is for a particular
out of tree modules.

						- Ted
