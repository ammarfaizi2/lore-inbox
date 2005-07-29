Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVG2P3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVG2P3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVG2P2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:28:55 -0400
Received: from science.horizon.com ([192.35.100.1]:57920 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262620AbVG2P2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:28:52 -0400
Date: 29 Jul 2005 11:28:49 -0400
Message-ID: <20050729152849.29241.qmail@science.horizon.com>
From: linux@horizon.com
To: brianhsu.hsu@qmail.com, linux-kernel@vger.kernel.org
Subject: Re: How to get dentry from inode number?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How can I get a full pathname from an inode number ? (Our data
> structure only keep track inode number instead of pathname in
> order to keep thin, so don't have any information but inode
> number.)

Except in extreme circumstances (there's some horrible kludgery in the
NFS code), you don't.  Just store a dentry pointer to begin with; it's
easy to map from dentry to inode.

In addition to files with multiple names, you can have files with no
names, made by the usual Unix trick of deleting a file after opening it.


The NFS kludgery is required by the short-sighted design of the NFS
protocol.  Don't emulate it, or you will be lynched by a mob of angry
kernel developers with torches and pitchforks.
