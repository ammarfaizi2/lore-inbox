Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWBJMbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWBJMbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWBJMbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:31:44 -0500
Received: from main.gmane.org ([80.91.229.2]:41098 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751239AbWBJMbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:31:43 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Philippe Seewer <philippe.seewer@bfh.ch>
Subject: Re: libata janitor project
Date: Fri, 10 Feb 2006 12:27:49 +0000 (UTC)
Message-ID: <loom.20060210T132349-817@post.gmane.org>
References: <43EC7EFB.5020100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 147.87.143.179 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060124 Firefox/1.5.0.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik <at> pobox.com> writes:

> 
> 
> Long term, we should work to replace the assert() in libata with 
> standard kernel WARN_ON().
> 
> If someone wanted to handle that conversion, that would be useful.  Make 
> sure to pay attention, the sense of each test must be reversed.
> 
> 	Jeff
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Just so stupid little me understands this:
replace for example: 
  assert(sg != NULL)
with
  WARN_ON(sg == NULL)

right? 
...What about WARN_ON being defined bu HAVE_ARCH_BUG_ON and assert by ATA_DEBUG?


