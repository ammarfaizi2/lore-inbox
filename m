Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTFEGyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 02:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTFEGyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 02:54:11 -0400
Received: from adsl-64-166-42-134.dsl.scrm01.pacbell.net ([64.166.42.134]:48645
	"HELO www.wavicle.org") by vger.kernel.org with SMTP
	id S264477AbTFEGyK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 02:54:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Joe Burks <jburks@wavicle.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: Why am I getting Kernel Panic VFS cannot mount root fs on 301?
Date: Thu, 5 Jun 2003 00:07:39 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200306041412.27897.jburks@wavicle.org> <20030604213950.GC2436@hh.idb.hist.no>
In-Reply-To: <20030604213950.GC2436@hh.idb.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306050007.39267.jburks@wavicle.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

Thank you for the quick response.  While I was un-modularizing everything per 
your message, I spotted the problem: I didn't have the IDE drivers getting 
built (probably because they are named "ATA/ATAPI/MFM/RLL" in the config 
menu).  All is relatively working now (I can't seem to open a console in X 
windows if I have devfs built - I think this has something to do with 
securetty, but I've made the devfs changes to that file and it is still not 
working).

Thanks for your help!

-Joe

On Wednesday 04 June 2003 02:39 pm, Helge Hafting wrote:
> On Wed, Jun 04, 2003 at 02:14:39PM -0700, Joe Burks wrote:
> Try to rule out modules problems, make a kernel where
> everything is compiled in.  If you aren't using a initrd
> then at least devfs, the fs used on your root, and the drivers
> for your ide controller _must_ be compiled in because
> modules cannot be loaded until _after_ the root
> fs is mounted.

