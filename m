Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261738AbSJQT7K>; Thu, 17 Oct 2002 15:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbSJQT7K>; Thu, 17 Oct 2002 15:59:10 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:23563
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261738AbSJQT7J>; Thu, 17 Oct 2002 15:59:09 -0400
Subject: Re: [PATCH] pre-decoded wchan output
From: Robert Love <rml@tech9.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       riel@conectiva.com.br
In-Reply-To: <20021017205803.A7555@infradead.org>
References: <1034882043.1072.589.camel@phantasy> 
	<20021017205803.A7555@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Oct 2002 16:04:36 -0400
Message-Id: <1034885077.718.595.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-17 at 15:58, Christoph Hellwig wrote:

> Can't you just left the old, nuerical one in even if CONFIG_KALLSYMS
> ise set?  One ifdef less and far less surprises..

But why?  Save the call to get_wchan()...

Ideally I would like to remove the field altogether but thats too much
breakage.

A value of zero in the field position is an indication the wchan file
exists, too.

The ifdefs there do not bother me.  I think its pretty clear why its
being done, although I could add a comment to the "0UL" value saying
"now in /proc/#/wchan" or whatever.

But, no, I do not agree.  No human can parse /proc/#/stats anyhow. 
Since procps needs to be updated for 3.0 anyhow, it will be fine.

	Robert Love

