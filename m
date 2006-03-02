Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWCBTuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWCBTuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbWCBTuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:50:06 -0500
Received: from ns2.suse.de ([195.135.220.15]:65215 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751687AbWCBTuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:50:05 -0500
From: Andi Kleen <ak@suse.de>
To: Martin Bligh <mbligh@google.com>
Subject: Re: x86_64 compile spewing hundreds of warnings - started 2.6.15-git8
Date: Thu, 2 Mar 2006 20:49:57 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <440748FD.8010806@google.com>
In-Reply-To: <440748FD.8010806@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603022049.57969.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 20:35, Martin Bligh wrote:

> include/asm/bitops.h:65: warning: read-write constraint does not allow a 
> register
> 
> 
> What do these mean?

They mean you have a buggy compiler.


> And how do we get rid of it? 
> 
> Presumably caused by this:
> 
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=636dd2b7def5c9c72551b51d4d516a65c269de08
> 
> or this:
> 
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=92934bcbf96bc9dc931c40ca5f1a57685b7b813b

It was the bitops.h constrain change.

The problem is that reverting them would be readding the problem. Maybe we need to 
#ifdef it.

-Andi


