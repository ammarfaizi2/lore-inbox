Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVJaVZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVJaVZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVJaVZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:25:07 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:44985 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932529AbVJaVZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:25:05 -0500
Date: Mon, 31 Oct 2005 14:25:03 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: ext2-devel@lists.sourceforge.net, sct@redhat.com, akpm@osdl.org,
       ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: What is the history of CONFIG_EXT{2,3}_CHECK?
Message-ID: <20051031212503.GY31368@schatzie.adilger.int>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	ext2-devel@lists.sourceforge.net, sct@redhat.com, akpm@osdl.org,
	ext3-users@redhat.com, linux-kernel@vger.kernel.org
References: <20051031001334.GP4180@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031001334.GP4180@stusta.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2005  01:13 +0100, Adrian Bunk wrote:
> Can anyone tell me the history of CONFIG_EXT{2,3}_CHECK?
> 
> There is code for a "check" option for mount if these options are 
> enabled, but there's no way to enable them.

These are expensive debugging options, which walk the inode/block bitmaps
for getting the group inode/block usage instead of using the group
summary data.  Not used very often but I suspect occasionally useful for
developers mucking with ext[23] internals.  Since it is developer-only
code it needs to be enabled with #define CONFIG_EXT[23]_CHECK in a
header or compile option.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

