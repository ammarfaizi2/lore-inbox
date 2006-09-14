Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWINHpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWINHpk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWINHpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:45:40 -0400
Received: from mail.suse.de ([195.135.220.2]:58003 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751436AbWINHpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:45:39 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Assignment of GDT entries
Date: Thu, 14 Sep 2006 08:00:13 +0200
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
References: <450854F3.20603@goop.org>
In-Reply-To: <450854F3.20603@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609140800.13735.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 September 2006 20:58, Jeremy Fitzhardinge wrote:
> What's the rationale for the current assignment of GDT entries?  In
> particular, this section:

AFAIK it was mostly for APM and various BIOS bugs.  IIRC Wine had 
some special requirements at some point too, but I can't remember them right
now. On x86-64 I use all GDT entries, although there are a few special 
ordering restrictions due to the semantics of SYSCALL. I ignored Wine too and 
so far nobody has complained, so whatever requirements they have they can't 
be that important.

> I'm asking because I'd like to use one of these entries for the PDA
> descriptor, so that it is on the same cache line as the TLS
> descriptors.  That way, the entry/exit segment register reloads would
> still only need to touch two GDT cache lines.  Would there be a real
> problem in doing this?

The only way to find out would be to do it. It's quite possible that all 
the systems with APM BIOS that needed it are long beyond their MTBF.

-Andi
