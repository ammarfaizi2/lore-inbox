Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVACVhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVACVhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVACVhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:37:23 -0500
Received: from holomorphy.com ([207.189.100.168]:39582 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261395AbVACVhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:37:13 -0500
Date: Mon, 3 Jan 2005 13:36:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [3/8] kill gen_init_cpio.c printk() of size_t warning
Message-ID: <20050103213627.GS29332@holomorphy.com>
References: <20050103172013.GA29332@holomorphy.com> <41D9881B.4020000@pobox.com> <20050103180915.GK29332@holomorphy.com> <Pine.LNX.4.61.0501031329030.13385@chaos.analogic.com> <crccas$la0$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <crccas$la0$1@terminus.zytor.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.61.0501031329030.13385@chaos.analogic.com>
By author:    linux-os <linux-os@chaos.analogic.com>
In newsgroup: linux.dev.kernel
>> But it's wrong.
>> It should be:
>>> +		strlen(target) + 1U,	/* filesize */
>> strlen() already returns a size_t. You need an unsigned 1 to
>> not affect it. As previously stated, an integer constant
>> is an int, not an unsigned int unless you make it so with
>> "U".

On Mon, Jan 03, 2005 at 09:09:48PM +0000, H. Peter Anvin wrote:
> Dear Wrongbot,
> Bullshit.  Signed is promoted to unsigned.

I'm not sure who you're responding to here, but gcc emitted an actual
warning and I was only attempting to carry out the minimal effort
necessary to silence it. I'm not really interested in creating or
being involved with controversy, just silencing the core build in the
least invasive and so on way possible, leaving deeper drivers/ issues
to the resolution of the true underlying problems.

I don't have anything to do with the code excerpt above; I merely
followed the style of the other unsigned integer coercions in the file.


-- wli
