Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289962AbSAWSqo>; Wed, 23 Jan 2002 13:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289963AbSAWSqe>; Wed, 23 Jan 2002 13:46:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16513 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289962AbSAWSqX>;
	Wed, 23 Jan 2002 13:46:23 -0500
Date: Wed, 23 Jan 2002 10:44:38 -0800 (PST)
Message-Id: <20020123.104438.71552152.davem@redhat.com>
To: riel@conectiva.com.br
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH *] rmap VM, version 12
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0201231513571.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201231513571.32617-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Wed, 23 Jan 2002 15:14:42 -0200 (BRST)

     - use fast pte quicklists on non-pae machines           (Andrea Arcangeli)

Does this work on SMP?  I remember they were turned off because
they were simply broken on SMP.

The problem is that when vmalloc() or whatever kernel mappings change
you have to update all the quicklist page tables to match.

Andrea probably fixed this, I haven't looked at the patch.
If so, ignoreme.
