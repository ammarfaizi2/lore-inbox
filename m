Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWAKAYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWAKAYa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWAKAYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:24:30 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:60186 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161033AbWAKAY3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:24:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BagKe4ZdLYPC0H7zu2cAPIoZkXrLl06Ox6tJBEX2jM74BwQTjfpuarLNAnVmD5u1S8yJEQZJEuRH7oczUdJG/u/V9sJ77GVBRjXLtFPCLOglHlrqSj4KafQlwOAu5BDmtFrbq6DeFkBhzohtX4/9ANhnjWi4xDSRFcb/ZuatBco=
Message-ID: <4807377b0601101624m1e1eb636q99ae0792b0903c5a@mail.gmail.com>
Date: Tue, 10 Jan 2006 16:24:28 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: gcoady@gmail.com
Subject: Re: 2.4: e100 accounting bust for multiple adapters
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <e196s1pj6u4apbjhgdm3imij4a10s6nb87@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e196s1pj6u4apbjhgdm3imij4a10s6nb87@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Grant Coady <gcoady@gmail.com> wrote:
> Hi there,
>
> While testing for a different issue on a box with two e100 NICs I noticed
> that interrupt and other accounting are accumulated to the first e100 NIC.

are the two e100's on the same broadcast domain?  if they are you
might actually be transferring all traffic on eth0

e100 doesn't track its own interrupt counts, the kernel does that for us.

Jesse
