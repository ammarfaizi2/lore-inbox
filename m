Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbUKLO5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbUKLO5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 09:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUKLO5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 09:57:52 -0500
Received: from nevyn.them.org ([66.93.172.17]:38867 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262537AbUKLO5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 09:57:42 -0500
Date: Fri, 12 Nov 2004 09:57:33 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] FRV: Generate more useful debug info
Message-ID: <20041112145733.GA26482@nevyn.them.org>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20041101162929.63af1d0d.akpm@osdl.org> <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <200411011930.iA1JUMgs023243@warthog.cambridge.redhat.com> <5109.1099394496@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5109.1099394496@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 11:21:36AM +0000, David Howells wrote:
> 
> > Generates rejects against Sam's tree and appears to be unrelated to FRV,
> > yes?
> 
> I know not Sam's tree.
> 
> It's a generic thing. "gcc -g" does not cause compiled .S files to include
> debugging information, and -O1 optimised code is more debuggable than -O2
> optimised code.

FYI, "gcc -g" _should_ cause .S files to include assembler debugging
information.  If it doesn't, that's a bug in your port.

*asm_debug:
%{gstabs*:--gstabs}%{!gstabs*:%{g*:--gdwarf2}}

-- 
Daniel Jacobowitz
