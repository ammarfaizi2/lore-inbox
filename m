Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSDZQjk>; Fri, 26 Apr 2002 12:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSDZQjj>; Fri, 26 Apr 2002 12:39:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40713 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314080AbSDZQjj>;
	Fri, 26 Apr 2002 12:39:39 -0400
Message-ID: <3CC982FC.C2B6F099@zip.com.au>
Date: Fri, 26 Apr 2002 09:40:28 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: maneesh@in.ibm.com
CC: LKML <linux-kernel@vger.kernel.org>, viro@math.psu.edu
Subject: Re: [RFC] link_path_walk cleanup
In-Reply-To: <20020426192146.M31039@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni wrote:
> 
>..
> +static inline int walk_one(struct nameidata *nd)

This function is hundreds and hundreds of bytes of code.  It has
three call sites.  Making it an inline is very inefficient!

-
