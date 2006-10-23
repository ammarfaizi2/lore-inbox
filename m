Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWJWOPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWJWOPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWJWOPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:15:24 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:42139 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751477AbWJWOPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:15:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vTyNe6uDjIR3Gz+nfhXpbLBO7y5v/chNkTIKfZq44nEtZZ+xg2/mhrg6Duoyj9yMe8nAB4KvXmF4b5jCSdlq0CDFIv36BA5bmE9JvqlO6lhkW5/lOWGii6vj1tbHi/o5giYCj61v7WN3n40ZkAPRvRlcuVQuanMREEIPxhYX3zo=  ;
Message-ID: <453CCE75.20302@yahoo.com.au>
Date: Tue, 24 Oct 2006 00:15:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <1161605379.3315.23.camel@nigel.suspend2.net> <200610231607.17525.rjw@sisk.pl>
In-Reply-To: <200610231607.17525.rjw@sisk.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:

> This case is a bit special.  I don't think it would be right to require every
> device driver writer to avoid modifying RCU pages from the interrupt
> context, because that would break the suspend to disk ...
> 
> Besides, if there is an RCU page that we _know_ we can use to store the image
> in it, we can just include this page in the image without copying.  This
> already gives us one extra free page for the rest of the image and we can
> _avoid_ creating two images which suspend2 does and which adds a _lot_ of
> complexity to the code.

If you don't mind me asking... what are these RCU pages you speak of?
I couldn't work it out by grepping kernel/power/*

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
