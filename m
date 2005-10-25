Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVJYQNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVJYQNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 12:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVJYQNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 12:13:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40136 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932198AbVJYQNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 12:13:31 -0400
Date: Tue, 25 Oct 2005 17:13:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@gmail.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: 2.6.14-rc5-mm1
Message-ID: <20051025161326.GA31122@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@gmail.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	Andrew Vasquez <andrew.vasquez@qlogic.com>
References: <20051024014838.0dd491bb.akpm@osdl.org> <1130186927.6831.23.camel@localhost.localdomain> <20051024141646.6265c0da.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024141646.6265c0da.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 02:16:46PM -0700, Andrew Morton wrote:
> qla2x00_probe_one() has called qla2x00_free_device() and
> qla2x00_free_device() has locked up in
> wait_for_completion(&ha->dpc_exited);

one more reason to use one-for-one goto-style unwinding instead of
calling _free routines ;-)

While we're at it -  Andew, would you converting qla2xxx to the
kthread_ API for thread handling?

