Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268532AbUIQH3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268532AbUIQH3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268533AbUIQH1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:27:54 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:57613 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268532AbUIQH1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:27:02 -0400
Date: Fri, 17 Sep 2004 08:27:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 Merge: init hooks
Message-ID: <20040917082700.D10537@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1095333524.3324.186.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1095333524.3324.186.camel@laptop.cunninghams>; from ncunningham@linuxmail.org on Thu, Sep 16, 2004 at 09:18:45PM +1000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -static dev_t __init try_name(char *name, int part)
> +static dev_t try_name(char *name, int part)

> -dev_t __init name_to_dev_t(char *name)
> +dev_t name_to_dev_t(char *name)


>  }
> +/* Exported for Software Suspend */
> +EXPORT_SYMBOL(name_to_dev_t);

Again, absolutely no way we're gonna exports this to modules.  From what
I see your code is a total mess and getting it sane for a builin case alone
will take ages.  We can then think about making it modular, but I still doubt
it makes any sense

