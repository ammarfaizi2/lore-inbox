Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVDLIf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVDLIf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 04:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVDLIfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 04:35:55 -0400
Received: from fmr21.intel.com ([143.183.121.13]:27834 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262065AbVDLIft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 04:35:49 -0400
Message-Id: <200504120835.j3C8Zmg06782@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Prototype error in <linux/debugfs.h>
Date: Tue, 12 Apr 2005 01:35:51 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU/Oo7mWnnpEeXuRuCpxWM38OqnuQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To lazy to write a patch, the inline debugfs function declaration
for the following three functions disagree between CONFIG_DEBUG_FS
and !CONFIG_DEBUG_FS

4th argument mismatch, looks like an obvious copy-n-paste error.
u16, u32, and u32?


static inline struct dentry *debugfs_create_u16(const char *name, mode_t mode,
                                                struct dentry *parent,
                                                u8 *value)
{
        return ERR_PTR(-ENODEV);
}

static inline struct dentry *debugfs_create_u32(const char *name, mode_t mode,
                                                struct dentry *parent,
                                                u8 *value)
{
        return ERR_PTR(-ENODEV);
}

static inline struct dentry *debugfs_create_bool(const char *name, mode_t mode,
                                                 struct dentry *parent,
                                                 u8 *value)
{
        return ERR_PTR(-ENODEV);
}


