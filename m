Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUIMOEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUIMOEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUIMOEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:04:53 -0400
Received: from verein.lst.de ([213.95.11.210]:20942 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S266796AbUIMOEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:04:44 -0400
Date: Mon, 13 Sep 2004 16:04:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix reiser4 compilation for ->permission changes
Message-ID: <20040913140440.GA23541@lst.de>
References: <20040913140226.GA23510@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913140226.GA23510@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 04:02:26PM +0200, Christoph Hellwig wrote:
> remove reiser4 permission.  It only ends up calling generic_permission
> with no additional bits so it's completely unessecary.

Actually not.  I'm lost in the CPP abuse in reiser4, sorry.  Could
someone of the namesys folks please remove all the perm_plugin mess?
->permission is the only access checking method for filesystems,
everything else is supposed to happen through LSM which may use xattr
storage in the filesystem.

