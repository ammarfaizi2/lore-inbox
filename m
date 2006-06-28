Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161217AbWF1I5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbWF1I5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161240AbWF1I5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:57:42 -0400
Received: from ns1.suse.de ([195.135.220.2]:28391 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161217AbWF1I5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:57:42 -0400
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Date: Wed, 28 Jun 2006 10:53:15 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, drepper@redhat.com,
       roland@redhat.com, jakub@redhat.com
References: <200606210329_MC3-1-C305-E008@compuserve.com> <20060621081539.GA14227@elte.hu> <20060627224433.fb726e0c.pj@sgi.com>
In-Reply-To: <20060627224433.fb726e0c.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606281053.15681.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 June 2006 07:44, Paul Jackson wrote:
> > but my gut feeling is that we should add a proper sys_get_cpu() syscall 
> 
> Yes - this should be for more or less all arch's.

The whole point of the original implementation is to do a fast architecture specific call.
A slow generic call isn't very useful.

-Andi
 
