Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVGaUtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVGaUtU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 16:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVGaUtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 16:49:20 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:50561 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261885AbVGaUtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 16:49:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=IWBeEpNH0sduAoZrP5b4IEjBfb2aq9OJKeH+q8NIpA9+TnP/LWz3h3i5cRnsBlpcuG0dxvIAOIr1D3WAT3BhKVRaw2Usb/Tv8lqeQVYlYeNa7FR2kXIOWt7kqcMrZd1MPkZC4Lk/Z0x3xDQDR6ChbD668fWeoCEgY+WlZ5o3d3I=
Date: Mon, 1 Aug 2005 00:56:50 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6] (10/11) hwmon vs i2c, second round
Message-ID: <20050731205650.GA3963@mipter.zuzino.mipt.ru>
References: <20050731205933.2e2a957f.khali@linux-fr.org> <20050731220224.23136906.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731220224.23136906.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One nitpicking comment and two observations:

On Sun, Jul 31, 2005 at 10:02:24PM +0200, Jean Delvare wrote:
> I see very little reason why vid_from_reg and vid_to_reg are inlined.
> The former is not exactly short,

1)
				   and their arguments aren't known at
compile time,

[Compiler can optimise them away _completely_ if both arguments are known at
compile time or significantly of only one is known.]

> and they are never called in speed critical areas. Uninlining them should
> cause little performance loss if any, and saves a signficant space and
> compilation time as well.

2) VID_FROM_REG is asking for removal from lm85.

3) vid_to_reg is used only by atxp1.

