Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270947AbTGPQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270922AbTGPQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:30:16 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:17548
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S270947AbTGPQaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:30:14 -0400
Date: Wed, 16 Jul 2003 12:45:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Ben Collins <bcollins@debian.org>
Cc: Philippe Gramoull? <philippe.gramoulle@mmania.com>,
       linux-kernel@vger.kernel.org,
       Linux IEEE 1394 Devel Mailing List 
	<linux1394-devel@lists.sourceforge.net>
Subject: Re: 2.6.0-test1-mm1: bad: scheduling while atomic! after removing ohci1394 module
Message-ID: <20030716164506.GD5628@gtf.org>
References: <20030716180855.22d4a4f4.philippe.gramoulle@mmania.com> <20030716163648.GO685@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716163648.GO685@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 12:36:48PM -0400, Ben Collins wrote:
> So is kill_proc() bad while atomic, e.g. when a module is being removed?
> I'll look into it.

hmmm, that's a big strange.  During ->remove and module unload, you can
schedule and sleep.

	Jeff


