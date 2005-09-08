Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbVIHP1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbVIHP1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbVIHP1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:27:18 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:54629
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932691AbVIHP1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:27:17 -0400
Message-Id: <432074B302000078000244A3@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:28:19 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add stricmp
References: <43206F420200007800024455@emea1-mh.id2.novell.com> <20050908151754.GB11067@infradead.org>
In-Reply-To: <20050908151754.GB11067@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Christoph Hellwig <hch@infradead.org> 08.09.05 17:17:54 >>>
>On Thu, Sep 08, 2005 at 05:05:06PM +0200, Jan Beulich wrote:
>> (Note: Patch also attached because the inline version is certain to
get
>> line wrapped.)
>> 
>> While strnicmp existed in the set of string support routines,
stricmp
>> didn't, which this patch adjusts.
>
>I don't thing we should do case-insenstitive comparims in kernel, and
>in the few cases where we must (legacy OS fileystem support) it needs
>to be NLS-capable.

Then how am I supposed to do ASCII-only case-insensitive compares (i.e.
reading config files)? And why is there a strnicmp? If this is not going
to be available as general library routine, I'd just have to add this to
a place where it doesn't really belong.

>But once again we need to see the users anyway.  You're adding tons
of
>bloat in your patches without showing us an actually useful user.

The intended user can be seen at
http://forge.novell.com/modules/xfmod/project/?nlkd (and see also my
previous reply to your earlier, similar complaint).

Jan
