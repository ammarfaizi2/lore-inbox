Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270942AbTGPQjs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270949AbTGPQjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:39:48 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:39879 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S270942AbTGPQjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:39:47 -0400
Date: Wed, 16 Jul 2003 12:53:40 -0400
From: Ben Collins <bcollins@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Philippe Gramoull? <philippe.gramoulle@mmania.com>,
       linux-kernel@vger.kernel.org,
       Linux IEEE 1394 Devel Mailing List 
	<linux1394-devel@lists.sourceforge.net>
Subject: Re: 2.6.0-test1-mm1: bad: scheduling while atomic! after removing ohci1394 module
Message-ID: <20030716165339.GP685@phunnypharm.org>
References: <20030716180855.22d4a4f4.philippe.gramoulle@mmania.com> <20030716163648.GO685@phunnypharm.org> <20030716164506.GD5628@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716164506.GD5628@gtf.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 12:45:06PM -0400, Jeff Garzik wrote:
> On Wed, Jul 16, 2003 at 12:36:48PM -0400, Ben Collins wrote:
> > So is kill_proc() bad while atomic, e.g. when a module is being removed?
> > I'll look into it.
> 
> hmmm, that's a big strange.  During ->remove and module unload, you can
> schedule and sleep.

I'd have to check to make sure the remove callbacks are doing something
stupid in the ieee1394 subsystem, like causing this problem.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
