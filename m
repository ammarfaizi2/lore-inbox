Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbTD3Wwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbTD3Wwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:52:50 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:8392 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262486AbTD3Wwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:52:49 -0400
Date: Wed, 30 Apr 2003 18:43:46 -0400
From: Ben Collins <bcollins@debian.org>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus <torvalds@transmeta.com>
Subject: Re: [PATCH] ieee1394.c on - compilation errors
Message-ID: <20030430224346.GA372@phunnypharm.org>
References: <1051743594.5267.7.camel@flat41>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051743594.5267.7.camel@flat41>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 11:59:54PM +0100, Grzegorz Jaskiewicz wrote:
> Hello there!
> 
> Another trivial, monkeys job patch.
> 
> Anyway, it is good to look at some changes and learn :)
> 

Please inspect the logic before removing things :)

I already submitted a patch to Linus to fix this. The problem is that
class_num was used as an opaque way of determining what sort of device
(host/node/unitdir) it was dealing with on the ieee1394 bus. Your patch
would likely cause a lot of oopses.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
