Return-Path: <linux-kernel-owner+w=401wt.eu-S1753640AbXABReF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbXABReF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 12:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753665AbXABReF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 12:34:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48165 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640AbXABReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 12:34:04 -0500
Date: Tue, 2 Jan 2007 12:28:46 -0500
From: Dave Jones <davej@redhat.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Print sysrq-m messages with KERN_INFO priority
Message-ID: <20070102172846.GC7656@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan <alan@lxorguk.ukuu.org.uk>, Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <E1H0Uq5-0003Fo-1W@candygram.thunk.org> <20061229204247.be66c972.akpm@osdl.org> <20070102043743.GB15718@thunk.org> <20070102103332.46de83bd@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102103332.46de83bd@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 10:33:32AM +0000, Alan Cox wrote:
 > On Mon, 1 Jan 2007 23:37:43 -0500
 > Theodore Tso <tytso@mit.edu> wrote:
 > > > Is this patch a consistency thing?
 > > 
 > > The goal of the patch was to avoid filling /var/log/messages huge
 > > amounts of sysrq text.  Some of the sysrq commands, especially sysrq-m
 > > and sysrq-t emit a truly vast amount of information, and it's not
 > > really nice to have that filling up /var/log/messages.  
 > 
 > I find it extremely useful that it ends up in /var/log/messages so that I
 > can review the dump later. Often the first glance through a set of dumps
 > on things like a process deadlock don't reveal the right information and
 > you need to go back and look again.

Seconded.  And with the limited scrollback of the ringbuffer, sometimes
looking through the logs is the only way to get the info.

		Dave

-- 
http://www.codemonkey.org.uk
