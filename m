Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTENSt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTENSt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:49:56 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:15238 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263573AbTENStz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:49:55 -0400
Date: Wed, 14 May 2003 15:02:43 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@digeo.com>
cc: Dave McCracken <dmccr@us.ibm.com>, <mika.penttila@kolumbus.fi>,
       <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Race between vmtruncate and mapped areas?
In-Reply-To: <20030514105706.628fba15.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0305141501180.10617-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Andrew Morton wrote:

> It would be nice to make them go away - they cause problems.

Absolutely.  No way to know you can't objrmap these pages
and need to convert them to pte chains, so you end up leaking
them with objrmap...

Not to mention they could end up being outside of any VMA,
meaning there's no sane way to deal with them.

