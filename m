Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUJOWWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUJOWWm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUJOWWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:22:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3477 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264098AbUJOWVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:21:02 -0400
Subject: Re: [Ext2-devel] Ext3 -mm reservations code: is this fix really
	correct?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1097872144.4591.54.camel@localhost.localdomain>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	 <1097856114.4591.28.camel@localhost.localdomain>
	 <1097858401.1968.148.camel@sisko.scot.redhat.com>
	 <1097872144.4591.54.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1097878826.1968.162.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Oct 2004 23:20:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-10-15 at 21:29, mingming cao wrote:

> How about this? Haven't test it, will do it shortly.:)

                if ((my_rsv->rsv_start <= group_end_block) &&
-                               (my_rsv->rsv_end > group_end_block))
+                               (my_rsv->rsv_end > group_end_block) &&
+                               (start_block <= my_rsv->rsv_start))
                        return -1;
 
That new "<=" should be a ">=", shouldn't it?

Otherwise, looks OK.

--Stephen

