Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTDUSGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTDUSGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:06:05 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:16650 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261820AbTDUSGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:06:04 -0400
Date: Mon, 21 Apr 2003 19:18:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>
Subject: Re: [PATCH] n_hdlc.c 2.5.68
Message-ID: <20030421191806.A9837@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Fulghum <paulkf@microgate.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
	"torvalds@transmeta.com" <torvalds@transmeta.com>
References: <1050948742.1841.15.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1050948742.1841.15.camel@diemos>; from paulkf@microgate.com on Mon, Apr 21, 2003 at 01:12:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 01:12:22PM -0500, Paul Fulghum wrote:
> Patch to remove MODULE_USE_COUNT macros
> and make some functions static.

You also need to set the module owner. Once you're at it also
please try to initialize as much as possible of n_hdlc_ldisc
at compile, like:

struct tty_ldisc n_hdlc_ldisc {
	.foo	= bar,
	....
};

