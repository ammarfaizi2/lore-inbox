Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310806AbSDXJhD>; Wed, 24 Apr 2002 05:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310835AbSDXJhC>; Wed, 24 Apr 2002 05:37:02 -0400
Received: from dsl-213-023-038-128.arcor-ip.net ([213.23.38.128]:427 "EHLO
	starship") by vger.kernel.org with ESMTP id <S310806AbSDXJg7>;
	Wed, 24 Apr 2002 05:36:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.9 remove warnings
Date: Tue, 23 Apr 2002 11:37:03 +0200
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.org
In-Reply-To: <10704.1019533171@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16zwjP-0002Mw-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 April 2002 05:39, Keith Owens wrote:
> exit.c:40: warning: passing arg 1 of `__builtin_expect' makes integer from pointer without a cast

> -	if (unlikely(proc_dentry)) {
> +	if (unlikely(proc_dentry != NULL)) {

Have you checked to see if this produces the same code?  To be on the safe
side:

+	if (unlikely((ulong) proc_dentry)) {

-- 
Daniel
