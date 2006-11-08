Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423789AbWKHVSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423789AbWKHVSo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423710AbWKHVSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:18:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20185 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423790AbWKHVSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:18:43 -0500
Date: Wed, 8 Nov 2006 16:18:30 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-linuxkernel@reub.net>,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.19-rc5-mm1
Message-ID: <20061108211830.GB3309@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Reuben Farrelly <reuben-linuxkernel@reub.net>,
	linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
References: <20061108015452.a2bb40d2.akpm@osdl.org> <4551BB5E.6090602@reub.net> <20061108120547.78048229.akpm@osdl.org> <20061108201539.GB32721@redhat.com> <20061108123110.74dcb6e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108123110.74dcb6e3.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 12:31:10PM -0800, Andrew Morton wrote:

 > > So, why doesn't select set the symbol it's selecting to the
 > > same value as the symbol being configured ?
 > 
 > It would have to be "same or higher", where y > m
 > > That would solve the issue no?
 > 
 > It would sort-of-solve this issue.  But it wouldn't stop `select' from being a
 > pita.  I spent some time trying to reverse-engineer Reuben's config from
 > the tiny bit he shared with us and gave up because a twisty maze of selects
 > kept on insisting that CONFIG_CPU_FREQ_TABLE=y.

I have a vague recollection that we used to have depends in there, but
that didn't work out for other reasons (this is where my memory gets fuzzy).
I think it caused problems when you had forward referencing depends.
That may have been subsequently resolved in kconfig, so maybe its worth
trying again for .20

What's really strange is that this kconfig has been this way for a while,
and it's only really been causing problems the last few weeks. Hmm.

		Dave

-- 
http://www.codemonkey.org.uk
