Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVHLD3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVHLD3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 23:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVHLD3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 23:29:19 -0400
Received: from smtp.istop.com ([66.11.167.126]:32978 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751146AbVHLD3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 23:29:19 -0400
From: Daniel Phillips <phillips@istop.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS
Date: Fri, 12 Aug 2005 13:29:46 +1000
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Hugh Dickins <hugh@veritas.com>
References: <200508110812.59986.phillips@arcor.de> <20050808145430.15394c3c.akpm@osdl.org> <26569.1123752390@warthog.cambridge.redhat.com>
In-Reply-To: <26569.1123752390@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508121329.46533.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 August 2005 19:26, David Howells wrote:
> Daniel Phillips <phillips@arcor.de> wrote:
> > +	SetPageMiscFS(page);
>
> Can you please retain the *PageFsMisc names I've been using in my stuff?
>
> In my opinion putting the "Fs" bit first gives a clearer indication that
> this is a bit exclusively for the use of filesystems in general.

You also achieved some sort of new low point in the abuse of StudlyCaps there. 
Please, let's not get started on mixed case acronyms.

Anyway, it sounds like you want to bless the use of private page flags in 
filesystems.  That is most probably a bad idea.  Take a browse through the 
existing users and feast your eyes on the spectacular lack of elegance.

Regards,

Daniel
