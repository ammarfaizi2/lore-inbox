Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVANVGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVANVGa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVANVEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:04:02 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:57296 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261999AbVANUzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:55:38 -0500
Date: Fri, 14 Jan 2005 20:55:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Hsu I-Chieh <ejhsu@msn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: A question about anonymous page
In-Reply-To: <BAY5-F7C011AC3F39F654AACBBEA48B0@phx.gbl>
Message-ID: <Pine.LNX.4.44.0501142043180.2973-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, Hsu I-Chieh wrote:
> 
> I want to know if there is any condition that anonymous pages (allocated by 
> do_anonymous_page) may be mapped in process page tables two or more times.

An anonymous page mapped at different places in a single user address space?
No (except for the reserved zero page, used on read fault).  But mapped into
different user address spaces, forked off from a common ancestor?  Yes (and
might even be at different positions if mremap has been used to move some).

Unless we have a bug - why do you ask?

Hugh

