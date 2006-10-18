Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWJRJWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWJRJWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWJRJWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:22:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:11738 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750990AbWJRJWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:22:43 -0400
Date: Wed, 18 Oct 2006 10:22:41 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       hch@infradead.org, mhalcrow@us.ibm.com, penberg@cs.helsinki.fi,
       linux-fsdevel@vger.kernel.org
Subject: Re: fsstack: struct path
Message-ID: <20061018092241.GL29920@ftp.linux.org.uk>
References: <20061018042323.GA8537@filer.fsl.cs.sunysb.edu> <20061018013103.4ad6311a.akpm@osdl.org> <20061018013551.3745e1d5.akpm@osdl.org> <20061018090623.GK29920@ftp.linux.org.uk> <20061018021222.2c4d907c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018021222.2c4d907c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 02:12:22AM -0700, Andrew Morton wrote:
> > Yuck...  If we really want to switch to it (and I can give you a dozen
> > examples of possible users right now - starting with struct file), putting
> > namei_ into it is both uninformative and ugly.
> > 
> > I'm not sure what would be the good name here; "pathname" comes to mind,
> > but it suggests that we are dealing with a string.  And "location" is
> > too vague (and probably would cause fsckloads of conflicts itself).
> > 
> > Suggestions?  "pathname" would almost work; the difference is that this
> > is not a string but a node in tree that string resolves to.
> 
> path_item?

struct path_node, perhaps?
