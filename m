Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWDTREW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWDTREW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWDTREW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:04:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61114 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751135AbWDTREU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:04:20 -0400
Date: Thu, 20 Apr 2006 18:04:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tony Jones <tonyj@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 10/11] security: AppArmor - Add flags to d_path
Message-ID: <20060420170419.GA20791@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tony Jones <tonyj@suse.de>, Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
	linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175026.29149.23661.sendpatchset@ermintrude.int.wirex.com> <20060419221248.GB26694@infradead.org> <20060420053604.GA15332@suse.de> <1145521570.3023.8.camel@laptopd505.fenrus.org> <20060420164329.GA30219@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420164329.GA30219@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 09:43:29AM -0700, Tony Jones wrote:
> I can't tell if you are claiming there is a fundamental problem calling d_path
> *period* in this scenario. If so, I'd appreciate a little more concrete detail

The purpose of d_path is to give user information about a path, to be
used in things like procfs output.  For everything else it's fundamentally
broken and shouldn't be used.  And for exactly that reason it isn't used for
anything like that in the whole tree (except the possible fishy use in nfsd).

p.s.: I also see that your patch doesn't include on to export d_path so
couldn't actually use it anyway. Not that a patch to export it would ever
be ACKed for above reasons..

> 
> in the way of an actual example, this is a bit hand-wavy.
> 
> Or that you are just saying another version of "pathames are crap" which I'm 
> not sure if appropos to this patch itself.
> 
> If it's the former, I'll happily go off and write some code to test your
> assertion and it's ramifications if I can better understand what the actual
> assertion is :-)
> 
> Thanks
> 
> Tony
---end quoted text---
