Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbTFMT7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbTFMT7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:59:19 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:57730 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265502AbTFMT7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:59:17 -0400
Date: Fri, 13 Jun 2003 13:09:03 -0700
From: Andrew Morton <akpm@digeo.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Bug in 2.5.70-mm9: df: `/': Value too large for defined data
 type
Message-Id: <20030613130903.600310f0.akpm@digeo.com>
In-Reply-To: <200306131250.51502.schlicht@uni-mannheim.de>
References: <20030613013337.1a6789d9.akpm@digeo.com>
	<200306131250.51502.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2003 20:13:04.0395 (UTC) FILETIME=[3261CDB0:01C331E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> When I enter 'df' in my bash with -mm9 I get following:
>   Filesystem           1k-blocks      Used Available Use% Mounted on
>   df: `/': Value too large for defined data type

The statfs64 patch isn't doing the right thing with reiserfs.  I shall
fix it.  Thanks.

