Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVDAFUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVDAFUS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 00:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVDAFUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 00:20:11 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:54280 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262631AbVDAFQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 00:16:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=oO1Bur59QQiO6515vgiNW4/MBVfJZeLWXzsn2tj7f6P+wgdkuq6mMYpRp7o+G9lCZpPjNoG8KfV+RKmKXpHAgcVuuwcm3g5DBOhB/7vaEooN3Tu9ORm4yqkcGY99Cfmr9v0HzbM/Xf7bF5zJ4gWoJsUV9MChqtbrijVJBQFzsyg=
Date: Fri, 1 Apr 2005 14:15:53 +0900
From: Tejun Heo <htejun@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, James.Bottomley@steeleye.com,
       axboe@suse.de, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 05/13] scsi: remove a timer race from scsi_queue_insert() and cleanup timer
Message-ID: <20050401051553.GE11318@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.4025028A@htj.dyndns.org> <20050331101353.GC13842@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331101353.GC13842@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Chritoph.

On Thu, Mar 31, 2005 at 11:13:53AM +0100, Christoph Hellwig wrote:
> >  		/* Queue the command and wait for it to complete */
> >  		/* Abuse eh_timeout in the scsi_cmnd struct for our purposes */
> >  		init_timer(&cmd->eh_timeout);
> > +		cmd->eh_timeout.function = NULL;
> 
> I'd rather not see aic7xxx poke even deeper into this internal code.
> Can you please switch it to use a timer of it's own first?

 Yes, I'll.

 Thanks.

-- 
tejun

