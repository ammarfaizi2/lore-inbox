Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbUBZWxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUBZWxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:53:13 -0500
Received: from holomorphy.com ([199.26.172.102]:9486 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261219AbUBZWwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:52:20 -0500
Date: Thu, 26 Feb 2004 14:52:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jochen Roemling <jochen@roemling.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
Message-ID: <20040226225214.GP693@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jochen Roemling <jochen@roemling.net>, linux-kernel@vger.kernel.org
References: <403E74D3.4000305@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403E74D3.4000305@roemling.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 11:36:03PM +0100, Jochen Roemling wrote:
> Hi,
> I'm using stock kernel 2.6.2. I have HUGETLB support compiled in.
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> When issuing this command in a C pgm
> shmid =shmget(IPC_PRIVATE, SOMESIZE, SHM_HUGETLB|IPC_CREAT|SHM_R|SHM_W)
> I get "Operation not Permitted" when running it as a normal user. It
> works for root. Without the SHM_HUGETLB flag it works fine for all users.
> How can I grant the permission to use HUGETLB to ordinary users?

(a) use the fs which uses fs permissions to grant users permission to
	fiddle with hugetlb
(b) man 2 capset
(c) proxy daemon for shmget()


-- wli
