Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVBOPTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVBOPTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVBOPTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:19:37 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:42650 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261751AbVBOPTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:19:31 -0500
Date: Tue, 15 Feb 2005 07:11:50 -0800
From: Paul Jackson <pj@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: ak@suse.de, raybry@sgi.com, ak@muc.de, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, stevel@mvista.com
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
Message-Id: <20050215071150.0b5112e9.pj@sgi.com>
In-Reply-To: <20050215121552.GB20607@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	<m1vf8yf2nu.fsf@muc.de>
	<42114279.5070202@sgi.com>
	<20050215115302.GB19586@wotan.suse.de>
	<20050215121552.GB20607@lnx-holt.americas.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it work to have the migration system call take exactly two node
numbers, the old and the new?  Have it migrate all pages in the address
space specified that are on the old node to the new node.  Leave any
other pages alone.  For one thing, this avoids passing a long list of
nodes, for an N-way to N-way migration. And for another thing, it seems
to solve some of the double migration and such issues.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
