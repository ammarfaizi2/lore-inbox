Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVA0UaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVA0UaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVA0UaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:30:05 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:40971 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261170AbVA0U3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:29:53 -0500
Date: Thu, 27 Jan 2005 21:29:47 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jaco Kroon <jaco@kroon.co.za>, sebekpi@poczta.onet.pl,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
Message-ID: <20050127202947.GD6010@pclin040.win.tue.nl>
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: MessageCare: pastinakel.tue.nl 1108; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 10:09:24AM -0800, Linus Torvalds wrote:

> So what _might_ happen is that we write the command, and then 
> i8042_wait_write() thinks that there is space to write the data 
> immediately, and writes the data, but now the data got lost because the 
> buffer was busy.

Hmm - I just answered the same post and concluded that I didnt understand,
so you have progressed further. I considered the same possibility,
but the data was not lost since we read it again later.
Only the ready flag was lost.

> The IO delay should be _before_ the read of the status, not after it.

Andries
