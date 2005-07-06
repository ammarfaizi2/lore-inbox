Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVGFVB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVGFVB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVGFU6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:58:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58600 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262288AbVGFUx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:53:29 -0400
Date: Wed, 6 Jul 2005 16:53:15 -0400
From: Dave Jones <davej@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: pmarques@grupopie.com, linux-kernel@vger.kernel.org
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
Message-ID: <20050706205315.GC27630@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, pmarques@grupopie.com,
	linux-kernel@vger.kernel.org
References: <42CBE97C.2060208@grupopie.com> <20050706.125719.08321870.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706.125719.08321870.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 12:57:19PM -0700, David S. Miller wrote:
 > From: Paulo Marques <pmarques@grupopie.com>
 > Date: Wed, 06 Jul 2005 15:23:56 +0100
 > 
 > > What is weird is that most of the extra time is being accounted as 
 > > user-space time, but the user-space application is exactly the same in 
 > > both runs, only the "randomize_va_space" parameter changed.
 > 
 > It might be attributable to more cpu cache misses in userspace since
 > the virtual addresses of everything are changing each and every
 > invocation.

On Transmeta CPUs that probably triggers a retranslation of
x86->native bytecode, if it thinks it hasn't seen code at that
address before.

		Dave

