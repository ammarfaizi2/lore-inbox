Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWEKTdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWEKTdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 15:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWEKTdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 15:33:41 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:7263 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750734AbWEKTdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 15:33:40 -0400
Date: Thu, 11 May 2006 12:33:08 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       hch@lst.de, bcrl@kvack.org, cel@citi.umich.edu,
       Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH 1/4] Vectorize aio_read/aio_write methods
Message-ID: <20060511193308.GM21588@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com> <1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com> <20060511113932.535056c6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511113932.535056c6.akpm@osdl.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 11:39:32AM -0700, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > This patch vectorizes aio_read() and aio_write() methods to prepare
> > for collapsing all aio & vectored operations into one interface -
> > which is aio_read()/aio_write().
> 
> There've been significant ocfs2 changes.  I redid things as below, but
> didn't try super-hard.  Please check that it all looks sane.
Yeah, that looks good. Thanks Andrew!
	--Mark
  
--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
