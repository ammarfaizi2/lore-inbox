Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVCHHiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVCHHiY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVCHHiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 02:38:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:22936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261858AbVCHHiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 02:38:22 -0500
Date: Mon, 7 Mar 2005 23:37:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: sct@redhat.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC] ext3/jbd race: releasing in-use
 journal_heads
Message-Id: <20050307233742.79737606.akpm@osdl.org>
In-Reply-To: <20050308072650.GA3998@in.ibm.com>
References: <20050304160451.4c33919c.akpm@osdl.org>
	<1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050307123118.3a946bc8.akpm@osdl.org>
	<1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050307131113.0fd7477e.akpm@osdl.org>
	<1110230527.15117.625.camel@sisko.sctweedie.blueyonder.co.uk>
	<1110237205.15117.702.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050307155001.099352b5.akpm@osdl.org>
	<20050308062827.GA3756@in.ibm.com>
	<20050307224618.1cae3425.akpm@osdl.org>
	<20050308072650.GA3998@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> (let me know if the interface in the patch
>  I just posted seems like the right direction to use when we go for the
>  cleanup)

Well what are the semantics?  Pass in an inclusive max_index and the gang
lookup functions terminate when they hit an item whose index is greater
than max_index?  And return the number of items thus found?

Seems sensible, and all the comparisons do the right thing if max_index = -1.
