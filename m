Return-Path: <linux-kernel-owner+w=401wt.eu-S1751925AbXAREep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbXAREep (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 23:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbXAREep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 23:34:45 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:44889 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbXAREeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 23:34:44 -0500
Date: Wed, 17 Jan 2007 20:34:21 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Seetharam Dharmosoth <seetharam_kernel@yahoo.co.in>
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: query related to serial console
Message-Id: <20070117203421.6d80be93.randy.dunlap@oracle.com>
In-Reply-To: <20070118041017.56140.qmail@web7714.mail.in.yahoo.com>
References: <20070117114855.GB25077@harddisk-recovery.com>
	<20070118041017.56140.qmail@web7714.mail.in.yahoo.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007 04:10:17 +0000 (GMT) Seetharam Dharmosoth wrote:

(please don't top-post)


> Generally sysrq will work with serial console right?
> 
> suppose system is connected through serial port to the
> other system, (ie serial console), at this time we can
> fire some set of commands through the serial console.
> 
> the sequesnce is as follows  
> do ctrl+]
> send brk
> then some commands
> 
> What is my question is con't we pass commands directly
> 
> to the console (without send brk signal) ?
> 
> This is a feature in Solris..
> 
> I am looking in Linux but, uable to find it.
> 
> can you please help me
> 
> Thanks
> Seetharam

Hi,
It's quite possible that I misunderstand your question,
but anyway:

Alt-Sysrq-<key> is a route into the kernel sysrq handler instead
of a route into the shell that the serial console is connected to,
so something needs to signal that condition (like a BREAK).

Or a specialized (serial) console app could know other ways of
recognizing sysrq keys.  Or you could use /proc/sysrq-trigger:
	echo b > /proc/sysrq-trigger


> --- Erik Mouw <erik@harddisk-recovery.com> wrote:
> 
> > On Wed, Jan 17, 2007 at 11:26:54AM +0000, Seetharam
> > Dharmosoth wrote:
> > > Is Linux having 'non-break interface for serial
> > > console' ?
> > 
> > No idea. Could you explain what a 'non-break
> > interface for serial
> > console' is?


---
~Randy
