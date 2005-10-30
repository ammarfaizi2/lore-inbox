Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVJ3MYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVJ3MYx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 07:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVJ3MYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 07:24:53 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:59611
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932140AbVJ3MYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 07:24:52 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: What's wrong with tmpfs?
Date: Sun, 30 Oct 2005 06:24:38 -0600
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510300624.38794.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under User Mode Linux in 2.6.14, would someone please explain to me why this 
test:

static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
{
        int err;

        if (mnt->mnt_sb->s_flags & MS_NOUSER)
                return -EINVAL;

Is triggering when I try to mount tmpfs?  Is this happening for anybody else?  
Shouldn't I be getting a fresh superblock or something?  (Is this just a User 
Mode Linux issue?  Haven't got a spare box set up to boot it on real hardware 
just yet...)

If somebody needs a reproduction sequence, I'm happy to oblige.  In theory 
"mount -t tmpfs /mnt /mnt" should do it, but if it was _that_ simple it 
wouldn't have shipped...

Rob
