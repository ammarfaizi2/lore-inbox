Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWE3Jx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWE3Jx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWE3Jx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:53:27 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:12473 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932220AbWE3Jx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:53:26 -0400
Date: Tue, 30 May 2006 12:53:20 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: "=?utf-8?B?amVzc2VcKOW7uuiIiFwp?=" <jesse@icplus.com.tw>
cc: Andrew Morton <akpm@osdl.org>, romieu@fr.zoreil.com, dvrabel@cantab.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net
Subject: Re: Sign-off for the IP1000A driver before inclusion
In-Reply-To: <026801c683c8$e3f63860$4964a8c0@icplus.com.tw>
Message-ID: <Pine.LNX.4.58.0605301245260.22126@sbz-30.cs.Helsinki.FI>
References: <84144f020605230001s32b29f59w8f95c67fad7b380d@mail.gmail.com>
 <044a01c67ef8$9bdd0420$4964a8c0@icplus.com.tw>
 <Pine.LNX.4.58.0605240911400.26629@sbz-30.cs.Helsinki.FI>
 <021f01c683b0$34b5cbd0$4964a8c0@icplus.com.tw>
 <Pine.LNX.4.58.0605300915400.18933@sbz-30.cs.Helsinki.FI>
 <20060529234610.e5671e4c.akpm@osdl.org> <Pine.LNX.4.58.0605301024440.22126@sbz-30.cs.Helsinki.FI>
 <026801c683c8$e3f63860$4964a8c0@icplus.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

On Tue, 30 May 2006, jesse\(??\)~H~H\) wrote:
> Sorry for that. I try to generate the patch file. But I only can use
> "diff -uN" to generate it. The "diff --git" is not work. I still try to
> generate it.

I assume you're using Francois' git tree, right?  What you need to do is:

  - Check out netdev-ipg branch:

    git checkout netdev-ipg

  - Create a new branch against netdev-ipg (this is where you'll do the
    work):

    git checkout -b ipg-mine

  - Commit patches in your ipg-mine branch.  Use git update-index and git
    commit for this.  Please commit each changeset separately.  You can 
    use my patchset as a starting point:

     http://www.cs.helsinki.fi/u/penberg/linux/ip1000-jesse/

  - When you're done, you can generate diffs against the netdev-ipg 
    branch:

    git format-patch netdev-ipg ipg-mine

  - If you want, you can then delete your working branch:

    git checkout netdev-ipg ; git branch -D ipg-mine

On Tue, 30 May 2006, jesse\(??\)~H~H\) wrote:
> --Changelog:
> --Updata mentainer information
> --Remove some default phy params
> --Remove Threshold comfig and RxDMAInt from ipg_io_config(). Remove relative
> define form ipg.h
> --Remove and Rewrite ipg_config_autoneg() function.

The changelog isn't telling me much.  Why are you removing default phy 
params and the threshold config?

					Pekka
