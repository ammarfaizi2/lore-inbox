Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264924AbUFRCKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbUFRCKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 22:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbUFRCKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 22:10:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41901 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264924AbUFRCKo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 22:10:44 -0400
Date: Fri, 18 Jun 2004 03:10:43 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Chris Mason <mason@suse.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the mapping
Message-ID: <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk>
References: <1087523668.8002.103.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087523668.8002.103.camel@watt.suse.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 09:54:28PM -0400, Chris Mason wrote:
> __bd_forget will change the mapping for filesystem inodes without 
> waiting to make sure no users of the block device address space are 
> using that mapping.

Filesystem block device inodes have no business even looking at their
->i_mapping.  Where do you need to do that?
