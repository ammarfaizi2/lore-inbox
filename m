Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUIARBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUIARBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUIARBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:01:36 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:38148 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267335AbUIARAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:00:51 -0400
Date: Wed, 1 Sep 2004 18:00:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix leaks in ISOFS.
Message-ID: <20040901180050.A13768@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <200409011551.i81FpMUY000655@delerium.codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200409011551.i81FpMUY000655@delerium.codemonkey.org.uk>; from davej@redhat.com on Wed, Sep 01, 2004 at 04:51:22PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    MAYBE_CONTINUE(repeat,inode);
> +  if (buffer) kfree(buffer);

kfree(NULL) is just fine

