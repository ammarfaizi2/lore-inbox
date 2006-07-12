Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWGLTIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWGLTIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWGLTIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:08:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55985 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750796AbWGLTI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:08:29 -0400
Date: Wed, 12 Jul 2006 15:08:25 -0400
From: Dave Jones <davej@redhat.com>
To: Paul Paquette <paulp@bowes.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops during rsync
Message-ID: <20060712190825.GH14453@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Paul Paquette <paulp@bowes.com>, linux-kernel@vger.kernel.org
References: <44B5452B.4070503@bowes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B5452B.4070503@bowes.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 02:53:31PM -0400, Paul Paquette wrote:
 
 > When using rsync (version 2.6.8) as a nightly backup (involving 150+ GB) 
 > from one drive to the other, occasionally (once every 3 to 4 weeks) the 
 > system goes into a state where it can be pinged, but nothing else works 
 > - console or remote.  The last time this occurred was the first time I 
 > actually got an oops (or any message regarding a problem) in my logs as 
 > they usually just stopped.  I have also had similar hangs from other 
 > software (ie. updatedb).

This may be bad memory.

 > Jul 12 02:10:26 ECMServer kernel: [710038.538070] eax: 04000000   ebx: 04000000   ecx: c134e000   edx: 00000000

04000000 could be a single bit flip, that would bypass any NULL checks.

 > kernel paging request at virtual address 04000030

and then we dereference an offset from this 'address'.

Give it a going over with memtest for a while ?

		Dave

-- 
http://www.codemonkey.org.uk
