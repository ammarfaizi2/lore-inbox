Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVKIObM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVKIObM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVKIObL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:31:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36307 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751044AbVKIObJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:31:09 -0500
Date: Wed, 9 Nov 2005 14:31:07 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linuxram@us.ibm.com
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
Message-ID: <20051109143107.GV7992@ftp.linux.org.uk>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <E1EZnbA-000190-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EZnbA-000190-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 11:54:36AM +0100, Miklos Szeredi wrote:
> Shouldn't this check go before copy_tree()?  Not much point in copying
> the tree if we are sure it won't be used.

Incorrect.  Propagation nodes further down the tree can very well be
mountable.
