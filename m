Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTFFLVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 07:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTFFLVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 07:21:15 -0400
Received: from holomorphy.com ([66.224.33.161]:7615 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261216AbTFFLVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 07:21:14 -0400
Date: Fri, 6 Jun 2003 04:34:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jasper Spaans <jasper@vs19.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] fix location of zap_low_mappings
Message-ID: <20030606113443.GD8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jasper Spaans <jasper@vs19.net>, linux-kernel@vger.kernel.org
References: <20030606095749.GA13037@spaans.vs19.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606095749.GA13037@spaans.vs19.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 11:57:49AM +0200, Jasper Spaans wrote:
> When compiling current BK 2.5, I get a warning about zap_low_mappings not
> being declared. Moving it from smp.h to pgtable.h fixes this (and doesn't
> break my setup). 
> Does anyone object to this fix?
> [not Cc:-ed to the trivial patch monkey, as I'm not sure whether pgtable.h
>  is the right place to put this]

It's basically not supposed to be visible on UP. Perhaps a better
approach would be declare it in pgtable.h as you did, stub out the UP
case with an empty function, and un-#ifdef it from mem_init().


-- wli
