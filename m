Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUI0Jtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUI0Jtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUI0Jtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:49:55 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:46888
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S266547AbUI0Jtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:49:53 -0400
Message-Id: <s157f050.048@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Mon, 27 Sep 2004 11:50:49 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: i386 entry.S problems
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Christoph Hellwig <hch@infradead.org> 27.09.04 11:00:18 >>>
>On Mon, Sep 27, 2004 at 09:37:10AM +0200, Jan Beulich wrote:
>> >>> Christoph Hellwig <hch@infradead.org> 24.09.04 21:12:51 >>>
>> >> +#if !defined(CONFIG_REGPARM) || __GNUC__ < 3
>> >>  	pushl %ebp
>> >> +#endif
>> >
>> >CONFIG_REGPARM n eeds gcc 3.0 or later
>> 
>> Not sure what you try to point out here: the additions account for
>> exactly that.
>
>No, the || __GNUC__ < 3 is superflous.  if CONFIG_REGPARM is defined
>and __GNUC__ < 3 you have problems elsewhere already.

I don't think so. Otherwise, why would arch/i386/Makefile specifically
deal with this situation?

