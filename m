Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWBLTUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWBLTUm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 14:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWBLTUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 14:20:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750876AbWBLTUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 14:20:41 -0500
Date: Sun, 12 Feb 2006 14:19:34 -0500
From: Dave Jones <davej@redhat.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linda Walsh <lkml@tlinx.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
Message-ID: <20060212191934.GD21596@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Al Viro <viro@ftp.linux.org.uk>, Linda Walsh <lkml@tlinx.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212180601.GU27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 06:06:01PM +0000, Al Viro wrote:
 > On Fri, Feb 10, 2006 at 07:31:07PM -0800, Linda Walsh wrote:
 > > The maximum number of followed symlinks seems to be set to 5.
 > > 
 > > This seems small when compared to other filesystem limits.
 > > Is there some objection to it being raised?  Should it be
 > > something like Glib's '20' or '255'?
 > 
 > 	20 or 255 - not feasible (we'll get stack overflow from hell).
 > 8 - probably can be switched already; anybody who hadn't converted their
 > fs ->follow_link() to new model will just lose; in-tree instances are
 > already OK with that and out-of-tree folks had at least half a year
 > of warning.
 > 
 > 	Unless anybody yells right now, I'm switching it to 8 in post-2.6.16.

FWIW, Fedora/RHEL4 has done this for a long time.
I don't think I've ever seen any problems arise, but then symlink
mazes are thankfully somewhat rare.

		Dave

