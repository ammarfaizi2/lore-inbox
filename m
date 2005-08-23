Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVHWL4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVHWL4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 07:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVHWL4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 07:56:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37814 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932138AbVHWL4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 07:56:13 -0400
Date: Tue, 23 Aug 2005 12:55:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@gmail.com>,
       nathans@sgi.com, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       greg@kroah.com, hch@infradead.org
Subject: Re: [PATCH] mm: return ENOBUFS instead of ENOMEM in generic_file_buffered_write
Message-ID: <20050823115559.GA6348@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pekka J Enberg <penberg@cs.Helsinki.FI>,
	Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@gmail.com>,
	nathans@sgi.com, dtor_core@ameritech.net,
	linux-kernel@vger.kernel.org, greg@kroah.com
References: <11394.1124781401@kao2.melbourne.sgi.com> <200508190055.25747.dtor_core@ameritech.net> <20050823073258.GE743@frodo> <84144f02050823005573569fcb@mail.gmail.com> <20050823012839.649645c2.akpm@osdl.org> <Pine.LNX.4.58.0508231145060.30649@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508231145060.30649@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 11:46:33AM +0300, Pekka J Enberg wrote:
> As noticed by Dmitry Torokhov, write() can not return ENOMEM:
> 
> http://www.opengroup.org/onlinepubs/000095399/functions/write.html
> 
> Therefore fixup generic_file_buffered_write() in mm/filemap.c (pointed out by
> Nathan Scott).

We had this discussion before, for EACCESS then.  We've always been returning
more errnos than SuS mentioned and Linus declared it's fine.

