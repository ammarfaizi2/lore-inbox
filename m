Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVACWsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVACWsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVACWOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:14:15 -0500
Received: from holomorphy.com ([207.189.100.168]:60318 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261936AbVACWKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:10:31 -0500
Date: Mon, 3 Jan 2005 14:09:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [3/8] kill gen_init_cpio.c printk() of size_t warning
Message-ID: <20050103220945.GU29332@holomorphy.com>
References: <20050103172013.GA29332@holomorphy.com> <41D9881B.4020000@pobox.com> <20050103180915.GK29332@holomorphy.com> <Pine.LNX.4.61.0501031329030.13385@chaos.analogic.com> <crccas$la0$1@terminus.zytor.com> <20050103213627.GS29332@holomorphy.com> <20050103215503.GX26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103215503.GX26051@parcelfarce.linux.theplanet.co.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 01:36:27PM -0800, William Lee Irwin III wrote:
>> I'm not sure who you're responding to here, but gcc emitted an actual
>> warning and I was only attempting to carry out the minimal effort
>> necessary to silence it. I'm not really interested in creating or
>> being involved with controversy, just silencing the core build in the
>> least invasive and so on way possible, leaving deeper drivers/ issues
>> to the resolution of the true underlying problems.
>> I don't have anything to do with the code excerpt above; I merely
>> followed the style of the other unsigned integer coercions in the file.

On Mon, Jan 03, 2005 at 09:55:03PM +0000, Al Viro wrote:
> Egads...  Just use %zd for size_t.  It's going to have rank no less than
> that of int, so you'll get 1 converted to size_t and size_t as type of
> result.

My personal preference was to do that, but it would have been
inconsistent with the approach used in the rest of the file.


-- wli
