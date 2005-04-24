Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVDXJzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVDXJzA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 05:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVDXJzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 05:55:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36737 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262298AbVDXJy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 05:54:58 -0400
Date: Sun, 24 Apr 2005 10:54:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] unexport is_console_locked
Message-ID: <20050424095451.GA22171@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20050415151045.GK5456@stusta.de> <20050423164948.652cc82b.akpm@osdl.org> <1114303890.5443.4.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114303890.5443.4.camel@gaston>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 10:51:30AM +1000, Benjamin Herrenschmidt wrote:
> Yes, I do. Please, keep it exported. On that note, I don't understand
> that frenzy of unexporting everything you can, I find this useless
> burden in general.

If we ever want to a have a semi-stable driver API (1) we need to stop
exporting random symbols and move towards APIs that make sense and
operate at the right level instead of poking into implementation details.
Note that even without that goal only having the right primitives avaiable
to drivers makes sure they use the right tool instead of copy & pasting
random crap.

(1) that is changing only when we have a real need instead of all the time.

