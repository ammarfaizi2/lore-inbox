Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261798AbTCaTAk>; Mon, 31 Mar 2003 14:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261830AbTCaTAk>; Mon, 31 Mar 2003 14:00:40 -0500
Received: from holomorphy.com ([66.224.33.161]:39108 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261798AbTCaTAh>;
	Mon, 31 Mar 2003 14:00:37 -0500
Date: Mon, 31 Mar 2003 11:11:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Janet Morgan <janetmor@us.ibm.com>
Cc: akpm@digeo.com, suparna@in.ibm.com, bcrl@redhat.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] Retry based aio read - filesystem read changes
Message-ID: <20030331191123.GB13178@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Janet Morgan <janetmor@us.ibm.com>, akpm@digeo.com,
	suparna@in.ibm.com, bcrl@redhat.com, linux-aio@kvack.org,
	linux-kernel@vger.kernel.org
References: <20030305144754.A1600@in.ibm.com> <20030305150026.B1627@in.ibm.com> <20030305024254.7f154afc.akpm@digeo.com> <20030305174452.A1882@in.ibm.com> <3E8889B4.FB716506@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8889B4.FB716506@us.ibm.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 10:32:20AM -0800, Janet Morgan wrote:
>   70% of all calls to schedule were from __lock_page:
>         Based on the profile data, almost all calls to _lock_page were
>         from do_generic_mapping_read (see filemap.c/Line 101 below).
>         Suparna's patch already retries here.

Can you tell whether these are due to hash collisions or contention on
the same page?

If they're due to hash collisions, things could easily be done to help
(though they wouldn't guarantee not sleeping entirely they'd be good
for general performance).


-- wli
