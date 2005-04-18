Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVDRRns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVDRRns (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 13:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVDRRns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 13:43:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40665 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262147AbVDRRnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 13:43:47 -0400
Date: Mon, 18 Apr 2005 18:43:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lorenzo Hern?ndez Garc?a-Hierro <lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RLIMIT_NPROC enforcement during execve() calls
Message-ID: <20050418174346.GA28790@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lorenzo Hern?ndez Garc?a-Hierro <lorenzo@gnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1113845937.17341.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113845937.17341.29.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 07:38:57PM +0200, Lorenzo Hern?ndez Garc?a-Hierro wrote:
> Enforces the RLIMIT_NPROC limit by adding an additional check for
> execve(), as
> such limit is checked only during fork() calls.

What's the point? exec doesn't create new process and exec() shouldn't
start to fail just because someone lowered the rlimit a short while ago.

