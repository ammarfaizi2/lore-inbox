Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423658AbWJaVmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423658AbWJaVmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423666AbWJaVmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:42:00 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:42971 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1423658AbWJaVl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:41:59 -0500
Date: Tue, 31 Oct 2006 22:41:46 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>, Arnd Bergmann <arnd@arndb.de>,
       Christoph Hellwig <hch@lst.de>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: feature-removal-schedule obsoletes
Message-ID: <20061031214146.GB30739@wohnheim.fh-wedel.de>
References: <45324658.1000203@gmail.com> <20061016133352.GA23391@lst.de> <200610242124.49911.arnd@arndb.de> <4543162B.7030701@drzeus.cx> <20061031155756.GA23021@wohnheim.fh-wedel.de> <20061031193212.GC26625@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061031193212.GC26625@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 October 2006 19:32:12 +0000, Russell King wrote:
> On Tue, Oct 31, 2006 at 04:57:56PM +0100, J?rn Engel wrote:
> > 
> > Why does the MMC block driver use a thread?  Is there a technical
> > reason for this or could it be done in original process context as
> > well, removing some code and useless cpu scheduler overhead?
> 
> As I understand it, there is no guarantee that a block drivers request
> function will be called in process context - it could be called in
> interrupt context.

Makes some sense.  I would still like to understand when a request
function is called from interrupt context, but if it is, the thread is
certainly necessary.

Jörn

-- 
This above all: to thine own self be true.
-- Shakespeare
