Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWCMV7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWCMV7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWCMV7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:59:08 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:26317 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S932478AbWCMV66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:58:58 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch] Require VM86 with VESA framebuffer
Date: Mon, 13 Mar 2006 13:58:49 -0800
User-Agent: KMail/1.9.1
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Antonino Daplas <adaplas@pol.net>, Andi Kleen <ak@suse.de>
References: <200603131159_MC3-1-BA89-78CA@compuserve.com> <4415A586.1010404@linux.intel.com>
In-Reply-To: <4415A586.1010404@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603131358.50374.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 13, 2006 9:01 am, Arjan van de Ven wrote:
> Chuck Ebbert wrote:
> > In-Reply-To: <1142261096.25773.19.camel@localhost.localdomain>
> > References: <1142261096.25773.19.camel@localhost.localdomain>
> >
> > On Mon, 13 Mar 2006 14:44:56 +0000, Alan Cox wrote:
> >> VESA does not require VM86 so this change is completely wrong.
> >
> > What is this all about then?
>
> that is about X requiring it. Not about anything kernel related.

And X doesn't actually require it, it's just that some builds of the X 
int10 and VBE libraries assume it's available.  They can be configured 
to use an x86 emulator instead, and probably should be by default so 
that non-x86 systems have a better chance of working (code coverage and 
all that).

Jesse
