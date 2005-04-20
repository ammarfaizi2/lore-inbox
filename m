Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVDTP52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVDTP52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 11:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVDTP51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 11:57:27 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:59959 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261702AbVDTP5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 11:57:24 -0400
Date: Wed, 20 Apr 2005 17:57:23 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: linux@horizon.com
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: enforcing DB immutability
Message-ID: <20050420155723.GC27307@harddisk-recovery.com>
References: <20050420084115.2699.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050420084115.2699.qmail@science.horizon.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 08:41:15AM -0000, linux@horizon.com wrote:
> [A discussion on the git list about how to provide a hardlinked file
> that *cannot* me modified by an editor, but must be replaced by
> a new copy.]

Some time ago there was somebody working on copy-on-write links: once
you modify a cow-linked file, the file contents are copied, the file is
unlinked and you can safely work on the new file. It has some horrible
semantics in that the inode number of the opened file changes, I don't
know if applications are or should be aware of that.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
