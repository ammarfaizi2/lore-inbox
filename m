Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbUCCQAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 11:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUCCQAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 11:00:13 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:62368 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262502AbUCCQAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 11:00:09 -0500
Date: Wed, 03 Mar 2004 09:58:44 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <7710000.1078329523@[10.1.1.4]>
In-Reply-To: <7440000.1078328791@[10.10.2.4]>
References: <20040303070933.GB4922@dualathlon.random>
 <20040303025820.2cf6078a.akpm@osdl.org> <7440000.1078328791@[10.10.2.4]>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, March 03, 2004 07:46:32 -0800 "Martin J. Bligh"
<mbligh@aracnet.com> wrote:

> There was talk at one point of moving the "unswappable" state down into 
> the struct page. Is that still realistic? It would seem rather more
> efficient, but I forget what problem we ran into with it.

It'd mean the page struct would have to have a count of the number of
mlock()ed regions it belongs to, and we'd have to update all the pages each
time we call it.

Dave McCracken

