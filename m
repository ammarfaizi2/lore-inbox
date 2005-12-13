Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVLMPVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVLMPVY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbVLMPVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:21:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59355 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964997AbVLMPVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:21:22 -0500
Date: Tue, 13 Dec 2005 15:21:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Gerd Knorr <kraxel@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] uml/xen: make the vt subsystem a runtime option
Message-ID: <20051213152121.GA4335@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Gerd Knorr <kraxel@suse.de>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <439EE38C.6020602@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439EE38C.6020602@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 04:06:52PM +0100, Gerd Knorr wrote:
>  #ifdef CONFIG_VT
> -	if (device == MKDEV(TTY_MAJOR,0)) {
> +	if (console_use_vt && device == MKDEV(TTY_MAJOR,0)) {

You don't register a cdev for this one below, so this can't be reached.

