Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTE3OpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 10:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263727AbTE3OpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 10:45:12 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:32787 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263726AbTE3OpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 10:45:11 -0400
Date: Fri, 30 May 2003 15:58:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4 bug: fifo-write causes diskwrites to read-only fs !
Message-ID: <20030530155820.A11144@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>,
	root@chaos.analogic.com, linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <Pine.LNX.4.53.0305281612160.13968@chaos> <200305282052.h4SKqUBw016537@verdi.et.tudelft.nl> <20030530132112.GA9572@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030530132112.GA9572@redhat.com>; from sct@redhat.com on Fri, May 30, 2003 at 02:21:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 02:21:12PM +0100, Stephen C. Tweedie wrote:
> +void update_mctime (struct inode *inode)
> +{
> +	if (inode->i_mtime == CURRENT_TIME && inode->i_ctime == CURRENT_TIME)
> +		return;
> +	if ( IS_RDONLY (inode) ) return;
> +	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
> +	mark_inode_dirty (inode);
> +}   /*  End Function update_mctime  */
> +

Yikes, this looks like devfs code!  Please try to use proper kernel style..

